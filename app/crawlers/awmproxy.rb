class Awmproxy
  LINK = 'http://awmproxy.com/freeproxy.php'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))

    browser = Watir::Browser.new :phantomjs
    browser = Watir::Browser.new :chrome
    browser.driver.manage.timeouts.page_load = 3
    browser.goto LINK
    html = browser.html
    browser.close

    doc = Nokogiri::HTML(html)

    doc.css('tbody tr').each do |node|
      result << node.text.split(' ').first
    end

    result
  end
end
