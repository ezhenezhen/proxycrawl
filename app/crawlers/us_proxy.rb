class UsProxy
  LINK = 'https://www.us-proxy.org'

  def parse
    result = []

    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody').each do |node|
      result << node.children[2].children[0].text + ':' + node.children[2].children[1].text
    end
    

    result.uniq!
    result
  end
end
