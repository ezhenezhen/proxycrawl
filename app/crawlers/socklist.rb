class Socklist
  LINK = 'https://sockslist.net/proxy/server-socks-hide-ip-address/'

  def parse
    result = []

    (1..3).each do |n|
      browser = Watir::Browser.new
      browser.goto LINK + "#{n}"
      html = browser.html
      browser.close

      doc = Nokogiri::HTML(html)
      doc.css('tr').each do |node|
        if node.search("a").first 
          result << node.search("a").first.attributes['href'].value.split('=').last
        end
      end
    end

    result
  end
end
