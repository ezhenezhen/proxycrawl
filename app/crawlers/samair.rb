class Samair
  # http://samair.ru/proxy/list-IP-port/proxy-1.htm
  # http://samair.ru/proxy/list-IP-port/proxy-20.htm last page of free proxies
  LINK = 'http://samair.ru/proxy/list-IP-port/proxy-'

  def parse
    result = []
    
    (1..20).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}.htm"))
      result += doc.css('#content').text.split("\n")
      result.delete(" ")
    end

    result.uniq!
    result
  end
end
