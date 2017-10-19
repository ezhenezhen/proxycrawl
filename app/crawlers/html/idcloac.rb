class Html::Idcloac
  LINK = 'http://www.idcloak.com/proxylist/free-proxy-ip-list.html#sort'
 
  def parse
    result = []
 
    (0..12).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('table#sort tr').each do |node|
        if node.css('td').count > 0
          result << node.css('td')[7].text + ':' + node.css('td')[6].text
        end
      end
    end
    
    result.uniq!
    result
  end
end
