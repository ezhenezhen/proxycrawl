class ProxyBesplatno
  LINK = 'http://proxy-besplatno.com/?page_num='
  PORTS = ['3128', '8080', '80']
  
  def parse
    result = []

    (1..374).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('tr').each do |node|
        PORTS.each do |port|
          result << node.children[1].text.squish + ':' + port
        end
      end
    end

    result.uniq!
    result
  end
end
