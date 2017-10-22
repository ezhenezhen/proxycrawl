# TODO: crawl http and socks proxies, send http to admin
namespace :crawlers do
  desc "Run all active crawlers"
  task run_all: :environment do
    start = Time.now
    proxy_count_before_task = Proxy.all.count
    all_crawlers = get_crawlers_list(:all)

    save_to_db(ips)
    finish(start)
  end

  task run_http: :environment do
    start = Time.now
    proxy_count_before_task = Proxy.all.count
    http_crawlers = get_crawlers_list(:http)
    http_crawlers.each do |crawler|
      crawler.parse
    end

    save_to_db(ips)
    finish(start)
  end

  task run_socks: :environment do
    start = Time.now
    proxy_count_before_task = Proxy.all.count
    socks_crawlers = get_crawlers_list(:socks)

    save_to_db(ips)
    finish(start)
  end

  task run_static: :environment do
    start = Time.now
    proxy_count_before_task = Proxy.all.count
    static_crawlers = get_crawlers_list(:static)

    save_to_db(ips)
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

    proxies.each do |proxy|
      ip = proxy.split(':').first.squish
      port = proxy.split(':').last.squish
      proxies_array << {
        ip: ip,
        port: port, 
        crawler_id: crawler.id
      }
    end

    Proxy.create(proxies_array)

    proxies_created = Proxy.where(crawler_id: crawler.id).count - count_of_proxies

    puts "#{proxies_created} proxies added".blue

    crawler.update_column(:last_ran_at, Time.now)
    crawler.update_column(:last_crawl_count, proxies_created)
  end

  def finish(start)
    finish = Time.now
    puts "Took #{Time.at(finish - start).utc.strftime("%H:%M:%S")} to parse it".yellow
  end

  def save_to_db(ips)
  end

  def send_to_admin
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
    when :all

    when :socks

    when :html

    when :static

    else

    end
  end

  def count_added_proxies(proxy_count_before_task)
    added_proxies = Proxy.all.count - proxy_count_before_task
    puts "Added #{added_proxies} proxies".yellow
  end
end

# 0 */2 * * * cd /rails/app/current && /usr/bin/rake RAILS_ENV=production crawlers:run_all
