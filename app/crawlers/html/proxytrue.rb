class Html::Proxytrue
  LINK = 'http://proxytrue.tk'
 
  def parse
    result = []
    
    100.times do
      doc = Nokogiri::HTML(open(LINK))
      doc.css('table>tr').each do |node|
        result << node.children[0].text
      end
    end
 
    result.uniq!  
    result
  end
end
