class ProxyList
  LINK = 'https://proxy-list.org/russian/index.php?p='
 
  def parse
    result = []
 
    (1..10).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('table li.proxy').each do |node|
        nodeText = node.children.text
        if nodeText['Proxy']
          result << Base64.decode64(nodeText.split("(")[1].split("'")[1])
        end
      end
    end
 
    result.uniq!
    result
  end
end
