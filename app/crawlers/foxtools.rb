class Foxtools
  LINK = 'http://foxtools.ru/Proxy?page='

  def parse
    result = []

    (0..13).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('tbody tr').each do |node|
        result << node.children[3].children.text + ':' + node.children[5].children.text
      end
    end

    result
  end
end

 