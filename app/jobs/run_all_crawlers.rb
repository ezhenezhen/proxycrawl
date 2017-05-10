class RunAllCrawlers < ApplicationJob
  def perform
    ids = Crawler.where(is_active: true).pluck(:id)

    ids.each do |id|
      app.get("/crawlers/#{id}/crawl")
    end
  end
end
