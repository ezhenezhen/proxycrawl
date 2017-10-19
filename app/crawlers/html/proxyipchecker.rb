class Html::Proxyipchecker
  LINK = 'http://proxyipchecker.com/api.html'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))

    doc.css('ul.freshproxies>li').each do |li|
      array = li.text.split(' ')
      result << array[0] + ':' + array[2]
    end

    result.uniq!
    result
  end
end
