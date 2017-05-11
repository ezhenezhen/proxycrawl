class Torvpn
  LINK = 'https://www.torvpn.com/en/proxy-list'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody tr').each do |node|
      result << node.children.children.first.text + ':' + node.children.children[1].text
    end

    result
  end
end
