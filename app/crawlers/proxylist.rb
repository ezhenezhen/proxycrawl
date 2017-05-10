class Proxylist
  # http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start=2
  # http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start=0
  LINK = 'http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl='

  def parse
    result = []
    
    browser = Watir::Browser.new :chrome
    browser.goto(LINK)
    html = browser.html
      
    doc = Nokogiri::HTML(html)

    doc.css('tr').each do |node|
      result << 
    end

    browser.close
   
    result
  end
end
