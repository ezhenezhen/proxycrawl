module CrawlersHelper
  def adding_proxies_icon(crawler)
    if crawler.proxies.count > 0 && crawler.proxies.order(:created_at).last.created_at > Date.yesterday
      "<i class='green checkmark icon'>".html_safe
    else
      "<i class='red remove icon'>".html_safe
    end
  end
end
