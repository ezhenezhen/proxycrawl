class Html::Hidemyip
  LINK = 'https://www.hide-my-ip.com/es/proxylist.shtml'

  def parse
    result = []
    browser = Watir::Browser.new :chrome
    browser.goto(LINK)

    html = browser.html
    doc = Nokogiri::HTML(html)

    browser.close
    parsed = JSON.parse doc.xpath('//script[not(@src)]')[3].children.first.text.squish.split(';').first.split('=').last.squish
    parsed.each do |p|
      result << p['i'] + ':' + p['p']
    end

    result.uniq!
    result
  end
end
