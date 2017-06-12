class ListProxylistplus
  LINK = 'http://list.proxylistplus.com/Fresh-HTTP-Proxy-List-'
 
  def parse
    result = []
    
    (1..6).each do |page|
      doc = Nokogiri::HTML(open(LINK + page.to_s))

      doc.css('table.bg tr').each do |node|
        if node.children[3] && node.children[5]
          result << node.children[3].text + ':' + node.children[5].text
        end
      end
    end
 
    result.uniq!
    result
  end
end
