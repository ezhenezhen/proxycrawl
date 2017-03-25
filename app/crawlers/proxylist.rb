class Proxylist
  # http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start=2
  # http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start=0
  LINK = 'http://www.proxylist.ro/search-free-proxy.php?country=&port=&anon=&ssl=&start='

  def parse
    result = []

    (0..2).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('tbody tr').each do |node|
        puts node.children.children.first.text + ':' + node.children.children[1].text
      end
    end

    result
  end
end
