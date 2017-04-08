class Proxylist
  # http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start=2
  # http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start=0
  LINK = 'http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl='

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody tr').each do |node|
      result << node.children.children.first.text + ':' + node.children.children[1].text
    end
   
    result
  end
end
