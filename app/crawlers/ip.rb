class Ip
  LINK = 'https://2ip.ru/proxy/'
  
  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))
    doc.css('td').each do |node|
      r = node.children.text.to_s.squish
      result << r unless r.blank?
    end

    result.uniq!
    result
  end
end
