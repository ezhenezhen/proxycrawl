module CrawlersHelper
  def adding_proxies_icon(crawler)
    true_false_icons(crawler.proxies.count > 0 && crawler.proxies.order(:created_at).last.created_at > Date.yesterday)
  end

  def true_false_icons(true_statement)
    true_statement ? "<i class='green checkmark icon'>".html_safe : "<i class='red remove icon'>".html_safe
  end
end
