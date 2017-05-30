class ProxyFresh
  LINK = 'http://proxy-fresh.ru/?page='

  def parse
    result = []

    (0..164).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('tbody tr').each do |node|
        result << node.children[3].children.text + ':' + node.children[5].text
      end
    end

    result.uniq!
    result
  end
end
