class Proxylist
  LINK = 'http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start='

  def parse
    result = []
    
    browser = Watir::Browser.new :chrome

    (0..1).each do |n|
      browser.goto(LINK + n.to_s)
      html = browser.html
      
      doc = Nokogiri::HTML(html)

      str = doc.css('tr')[2].children[1].text.squish
      ips = str.gsub(/z\(\d\d\d\-\d\d\d\);/, '').scan(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\s\d{2,4}/)

      ips.each do |ip|
        result << ip.sub(' ', ':')
      end
    end

    browser.close
    result.uniq!
    result
  end
end
