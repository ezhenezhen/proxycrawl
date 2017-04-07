class Ip
  LINK = 'https://2ip.ru/proxy/'
  
  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody tr').each do |node|
      result << node.children.children[3].text[5..21]
    end

    result
  end
end