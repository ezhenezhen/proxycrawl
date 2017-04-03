class FillInCrawlersAndCrawlerIdForProxies < ActiveRecord::Migration[5.0]
  def change
    crawler_files = Dir['app/crawlers/*.rb']

    crawler_files.each do |c|
      Crawler.create(name: File.basename(c, '.*').camelize.to_s) 
    end

    Proxy.all.each do |p|
      crawler = Crawler.find_by_name(p.site)
      p.update_column(:crawler_id, crawler.id)
    end
  end
end
