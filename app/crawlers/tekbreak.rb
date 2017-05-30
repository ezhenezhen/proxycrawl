class Tekbreak
  # http://proxy.tekbreak.com/{n}/{mode}
  LINK = 'http://proxy.tekbreak.com/200/html'
  
  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('body div').each do |node|
      result << node.children.first.text[9..23] + ':' + node.children[2].text[11..14]
    end

    result.uniq!
    result
  end
end
