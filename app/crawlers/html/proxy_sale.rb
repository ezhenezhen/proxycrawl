class Html::ProxySale
  LINK = 'http://free.proxy-sale.com/?pg='
  
  def parse
    result = []

    (0..85).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('tr').each do |node|
        if node.children[5] && node.children[5].children.first.attributes['src']
          port = node.children[5].children.first.attributes['src'].value.split('=').last
          result << node.children[1].text.to_s.squish + ':' + port
        end
      end
    end

    result.uniq!
    result
  end
end
