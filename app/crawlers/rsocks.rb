class Rsocks
  #https://rsocks.net/freeproxy
  #На сайте требуеться регестрация что бы получить больше прокси 
  #Login adacer2012
  #Password adacer2012
  LINK = 'https://rsocks.net/freeproxy?page='

  def parse
    result = []

    (0..46).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('table tr').each do |node|
        result << node.children[1].text + ':' + node.children[3].text
      end
    end
    
    result.uniq!
    result
  end
end