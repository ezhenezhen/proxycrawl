class Socklist
  

  def parse
    result = []
    browser = Watir::Browser.new :firefox
    browser.goto "http://sockslist.net/proxy/server-socks-hide-ip-address/"
   

    doc = Nokogiri::HTML(html)
    doc.css('tr').each do |node|
      if node.search("a").first 
        result << node.search("a").first.attributes['href'].value.split('=').last
      end
    end
    
    result
  end
end
