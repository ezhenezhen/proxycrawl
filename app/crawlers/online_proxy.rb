class OnlineProxy
  LINK = 'http://www.online-proxy.ru/'

  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))
    doc.css('tr').each do |node|
      if !node.children[3].blank? && node.children[5]
        result << node.children[3].text + ':' + node.children[5].text
      end
    end

    result.delete(':')
    result
  end
end
