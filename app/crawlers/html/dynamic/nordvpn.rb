class Html::Dynamic::Nordvpn
  LINK = 'https://nordvpn.com/ru/free-proxy-list/'

  def parse
    result = []
    browser = Watir::Browser.new :chrome
    
    browser.goto(LINK)
    browser.link(class: 'popup-close c-bw-d9 pull-right').wait_until_present.click
    sleep(1)

    # 1.times do |count|
    #   browser.link(class: "btn-brand btn-brand-yellow").click
    #   sleep(1)
    # end

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
