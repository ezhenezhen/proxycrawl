class Proxyhttp
  LINK = 'https://proxyhttp.net/free-list/anonymous-server-hide-ip-address/'

  def parse
    result = []

    browser = Watir::Browser.new :chrome
    
    (1..9).each do |n|
      browser.goto(LINK + n.to_s)
     
      html = browser.html
      doc = Nokogiri::HTML(html)

      doc.css('tr').each do |node|
        ip = node.children[1].text
        port = node.children[3].children.last.text.squish

        result << ip + ':' + port
      end
    end

    browser.close
    result.uniq!
    result
  end
end
