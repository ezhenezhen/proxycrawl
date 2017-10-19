class Html::Dynamic::Nordvpn
  LINK = 'https://nordvpn.com/ru/free-proxy-list/'

  def parse
    result = []
    browser = Watir::Browser.new :chrome
    
    browser.goto(LINK)
    browser.button(class: "close").click
    sleep(1)

    1.times do |count|
      browser.link(text: "Load more").click
      sleep(1)
    end

    html = browser.html
    doc = Nokogiri::HTML(html)

    doc.css('tbody>tr').each do |node|
      result << node.children[1].text + ':' + node.children[2].text
    end

    browser.close
    result.uniq!
    result
  end
end
