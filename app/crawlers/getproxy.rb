class Getproxy
  LINK = 'http://www.getproxy.jp/en/default/'

  def parse
    result = []
    
    (1..5).each do |n|
      doc = Nokogiri::HTML(open(LINK + n.to_s))
      doc.css('tr').each do |node|
        result << node.children[1].text
      end
    end

    result
  end
end
