namespace :crawlers do
  desc "Run all active crawlers"
  task run_all: :environment do
    proxy_count_before_task = Proxy.all.count
    crawlers = Crawler.where(is_active: true).order(:name)
    names = crawlers.pluck(:name)
    ids = crawlers.pluck(:id)

    puts "Crawlers to parse: #{names}".magenta

    ids.each do |id|
      start = Time.now
      crawler = Crawler.find(id)

      puts "Parsing a crawler #{crawler.name}".green

      begin
        proxies = crawler.name.constantize.new.parse
      rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, OpenURI::HTTPError => e
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
      finish = Time.now

      added_proxies = Proxy.all.count - proxy_count_before_task

      puts "Took #{Time.at(finish - start).utc.strftime("%H:%M:%S")} to parse it".yellow
      puts "Added #{added_proxies} proxies".yellow
    end
  end
end

# 0 */2 * * * cd /rails/app/current && /usr/bin/rake RAILS_ENV=production crawlers:run_all
