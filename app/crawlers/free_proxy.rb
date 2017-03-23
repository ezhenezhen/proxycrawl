class FreeProxy
  LINK = 'http://free-proxy.cz/en/proxylist/main/'

  def parse
    result = []

    (0..150).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n*1}"))
      doc.css('tbody tr').each do |node|
        nodeText = node.children[0].text
        if nodeText['document.write'] 
          nodeText['document.write(Base64.decode("'] = "" 
          nodeText['"))'] = "" 
          result <<  Base64.decode64(nodeText) + ':' + node.children[1].children.text
        end
      end
    end

    result
  end
end
