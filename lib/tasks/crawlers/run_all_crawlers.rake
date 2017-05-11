namespace :crawlers do
  desc "Run all active crawlers"
  task run_all: :environment do
    ids = Crawler.where(is_active: true)

    ids.each do |id|
      start = Time.now
      crawler = Crawler.find(id)

      puts "Parsing a crawler #{crawler.name}"

      begin
        proxies = crawler.name.constantize.new.parse
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        puts "Crawler #{crawler.name} failed to parse: " + e.to_s
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

      puts "#{proxies_created} proxies added"

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

      puts "Took #{finish - start} seconds to parse it (#{(finish - start)/60} minutes)"
    end
  end
end

# 0 */2 * * * cd /rails/app/current && /usr/bin/rake RAILS_ENV=production crawlers:run_all
