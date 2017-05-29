class ListProxylistplus
  LINK = 'http://list.proxylistplus.com/Fresh-HTTP-Proxy-List-1'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
      doc.css('table.bg td').each do |node|
        result << node.children[1].text + ':' + node.children[2].text
      end
    end
  
    result
  end
end