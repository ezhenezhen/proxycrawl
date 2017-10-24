# TODO: crawl http and socks proxies, send http to admin
namespace :crawlers do
  desc "Run all active crawlers"
  task run_dynamic: :environment do
    start = Time.now
    ips = []
    proxy_count_before_task = Proxy.all.count
    http_crawlers = get_crawlers_list(:dynamic)
    http_crawlers.each do |crawler|
      begin
        puts "Parsing #{crawler}".green
        ips = crawler.new.parse
        unless ips.blank?
          save_to_db(ips, crawler)
          send_to_admin(crawler)
        end
      rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, OpenURI::HTTPError, Selenium::WebDriver::Error::NoSuchWindowError, Errno::ETIMEDOUT => e
        puts "#{crawler} failed to parse: #{e}".red
      end
    end

    added_proxies = Proxy.all.count - proxy_count_before_task
    puts "#{added_proxies} total added proxies".green

    finish(start)
  end

  # TODO: collect all proxies, add a crawler name to the hash, take only uniq and then save to DB
  task run_static: :environment do
    start = Time.now
    ips = []
    proxy_count_before_task = Proxy.all.count
    http_crawlers = get_crawlers_list(:static)
    http_crawlers.each do |crawler|
      begin
        puts "Parsing #{crawler}".green
        ips = crawler.new.parse
        unless ips.blank?
          save_to_db(ips, crawler)
          send_to_admin(crawler)
        end
      rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, OpenURI::HTTPError, Errno::ETIMEDOUT => e
        puts "#{crawler} failed to parse: #{e}".red
      end
    end

    added_proxies = Proxy.all.count - proxy_count_before_task
    puts "#{added_proxies} total added proxies".green

    finish(start)
  end

  task run_socks: :environment do
    start = Time.now

    Sock.where(
      'created_at <= :one_day_ago',
      one_day_ago: Date.yesterday,
      type: 'socks5'
    ).delete_all

    socks = []
    begin
      socks << Socks::FreevpnNinja.new.parse
      socks << Socks::Gatherproxy.new.parse
      socks << Socks::HidemyName.new.parse
      socks << Socks::Livesocks.new.parse
      socks << Socks::Socklist.new.parse
      socks << Socks::Socks24.new.parse
      socks << Socks::SocksProxy.new.parse
      socks << Socks::Vipsocks.new.parse
    rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, OpenURI::HTTPError, Errno::ETIMEDOUT => e
      puts "One of the crawler failed to parse: #{e}".red
    end
   
    socks.flatten!
    socks.compact!
    socks.delete_if { |e| e.match(/[a-zA-Z]/) }
    socks.delete_if { |e| !e.match(/:/) }
    socks.uniq!

    puts "Parsed #{socks.count} unique socks".green

    proxies_array = []

    socks.each do |proxy|
      ip = proxy.split(':').first.squish
      port = proxy.split(':').last.squish

      if IPAddress.valid?(ip)
        proxies_array << {
          ip: ip,
          port: port,
          socks_type: 'socks5'
        }
      end
    end

    Sock.create(proxies_array)

    finish(start)
  end

  def parse(crawler)
    puts "Parsing a crawler #{crawler.name}".green

    begin
      proxies = crawler.name.constantize.new.parse
    rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, OpenURI::HTTPError, Errno::ETIMEDOUT => e
      puts "Crawler #{crawler.name} failed to parse: #{e}".red
    end

    proxies = [] if proxies.nil?

    proxies_array = []
    count_of_proxies = Proxy.where(crawler_id: crawler.id).count

    proxies_created = Proxy.where(crawler_id: crawler.id).count - count_of_proxies

    puts "#{proxies_created} proxies added".blue

    crawler.update_column(:last_ran_at, Time.now)
    crawler.update_column(:last_crawl_count, proxies_created)
  end

  def finish(start)
    finish = Time.now
    puts "Took #{Time.at(finish - start).utc.strftime("%H:%M:%S")} to parse it".yellow
  end

  def save_to_db(ips, crawler)
    proxies_array = []

    ips.each do |proxy|
      ip = proxy.split(':').first.squish
      port = proxy.split(':').last.squish
      proxies_array << {
        ip: ip,
        port: port, 
        crawler_id: Crawler.find_by_name(crawler.name.split('::').last).id,
      }
    end

    Proxy.create(proxies_array)
  end

  def send_to_admin(crawler)
    id = Crawler.find_by_name(crawler.to_s.split('::').last)
    proxies = Proxy.where(crawler_id: id).where('created_at >= ?', 2.days.ago)
    file_name = crawler.name + Time.now.strftime('%Y-%m-%d_%H-%M') + '.txt'

    result = []

    proxies.each do |proxy|
      result << proxy.ip + ':' + proxy.port
    end

    file = Tempfile.new(file_name)

    File.open(file, "w+") do |f|
      result.each { |proxy| f.puts(proxy) }
    end
    
    #TODO: export this into module
    # fails to send to site
    begin
      retries = 0

      RestClient.post(
        ENV['PROXY_SITE'],
        { file: File.open(file, 'r') },
        {
          'Authorization-Token' => ENV['PROXY_AUTH_TOKEN'],
          'content_type' => 'multipart/form-data'
        }
      )
    rescue => e
      retries += 1
      if retries < 3
        retry
      else
        logger.warn "Couldn't connect to site: #{e}"
      end
    end

    file.close
    file.unlink
  end

  def get_crawlers_list(type)
    case type
    when :socks
      result = []
      files = Dir.entries('app/crawlers/socks/').sort.drop(2)
      files.each do |f|
        result << ("Socks::" + f.split('.').first.camelize).constantize
      end

      result
    when :dynamic
      result = []
      files = Dir.entries('app/crawlers/html/dynamic/').sort.drop(2)
      files.each do |f|
        result << ("Html::Dynamic::" + f.split('.').first.camelize).constantize
      end

      result
    when :static
      result = []
      files = Dir.entries('app/crawlers/html/static/').sort.drop(2)
      files.each do |f|
        result << ("Html::Static::" + f.split('.').first.camelize).constantize
      end

      result
    end
  end

  def count_added_proxies(proxy_count_before_task)
    added_proxies = Proxy.all.count - proxy_count_before_task
    puts "Added #{added_proxies} proxies".yellow
  end
end
