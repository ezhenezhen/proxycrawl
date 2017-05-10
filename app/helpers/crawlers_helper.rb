module CrawlersHelper
  def adding_proxies_icon(crawler)
    if crawler.proxies.count > 0 && crawler.proxies.order(:created_at).last.created_at > Date.yesterday
      true
    else
      false
    end
  end
end
