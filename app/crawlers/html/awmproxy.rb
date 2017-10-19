class Html::Awmproxy
  LINK = 'http://awmproxy.com/freeproxy.php'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))

    doc.css('table tr').each do |node|
      result << node.children.first.text
    end

    result.uniq!
    result
  end
end
