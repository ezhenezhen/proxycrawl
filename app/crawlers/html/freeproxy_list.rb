class Html::FreeproxyList
  LINK = 'http://www.freeproxy-list.ru/api/proxy?anonymity=false&token=demo'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    result = doc.children.last.text.squish.split(' ')

    result.uniq!
    result
  end
end
