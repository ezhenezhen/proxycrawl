class Html::Static::HidemyName
  LINK = 'https://hidemy.name/en/proxy-list/?start='

  def parse
    result = []

    (0..13).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n*64}"))
      doc.css('tr').each do |node|
        if node.css('td').count > 0
          result << node.css('td').first.text + ':' + node.css('td')[1].text
        end
      end
    end

    result.uniq!
    result
  end
end
