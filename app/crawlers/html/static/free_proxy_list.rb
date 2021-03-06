class Html::Static::FreeProxyList
  LINK = 'http://free-proxy-list.net/'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody tr').each do |node|
      result << node.children.children.first.text + ':' + node.children.children[1].text
    end

    result.uniq!
    result
  end
end
