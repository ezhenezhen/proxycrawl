class FreeProxy
  LINK = 'http://free-proxy.cz/en/proxylist/main/'

  def parse
    result = []

    # only 9 pages without captcha
    (1..9).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n*1}"))
      doc.css('tbody tr').each do |node|
        nodeText = node.children[0].text
        if nodeText['document.write']
          result << Base64.decode64(nodeText.split("(").last) + ':' + node.children[1].children.text
        end
      end
    end

    result
  end
end
