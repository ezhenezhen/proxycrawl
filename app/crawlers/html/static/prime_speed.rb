class Html::Static::PrimeSpeed
  LINK = 'http://www.prime-speed.ru/proxy/free-proxy-list/all-working-proxies.php'
  
  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))
    result = doc.css('pre').text.squish.split(' ')
    result.shift(4)

    result.uniq!
    result
  end
end
