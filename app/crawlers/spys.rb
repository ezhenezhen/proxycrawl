class Spys
  LINK = 'http://spys.ru/en/'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('table tr.spy1xx font.spy14').each do |node|
      if nodeText['document.write']
        result << node.children[4].text + ':' + nodeText.children[5].text
      end
    end
  
    result.uniq!
    result
  end
end
