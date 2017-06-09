class Promicom
  LINK = 'http://promicom.by/tools/proxy/proxy.txt'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    result = doc.css('p').text.squish.split(' ')

    result.uniq!
    result
  end
end
