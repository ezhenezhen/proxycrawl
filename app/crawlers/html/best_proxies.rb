class Html::BestProxies
  LINK = 'https://best-proxies.ru/proxylist/free/'

  def parse
    result = []
    browser = Watir::Browser.new :chrome
    
    browser.goto(LINK)
    sleep(5)
    
    html = browser.html
    doc = Nokogiri::HTML(html)

    doc.css('tbody>tr').each do |node|
      if node.children[1]
        result << node.children[1].children[1].children[0].children[1].text.squish.split(' ').first
      end
    end

    browser.close

    result.uniq!
    result
  end
end
