class Html::Hidester
  LINK = 'https://hidester.com/proxylist/'

  def parse
    result = []

    browser = Watir::Browser.new :chrome
    browser.goto LINK 
    html = browser.html
    browser.close

    doc = Nokogiri::HTML(html)
    doc.css('tr').each do |node|
      ip = node.children[3].text.squish
      port = node.children[5].text.squish

      result << ip + ':' + port
    end

    result.uniq!
    result
  end
end
