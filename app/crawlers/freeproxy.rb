class Freeproxy

  LINKS = [
    'https://2freeproxy.com/anonymous-proxy.html',
    'https://2freeproxy.com/socks4.html',
    'https://2freeproxy.com/socks5.html',
    'https://2freeproxy.com/https-proxy.html',
    'https://2freeproxy.com/spoiled-proxy.html',
    'https://2freeproxy.com/standart-ports-proxy.html',
    'https://2freeproxy.com/us-proxy.html',
    'https://2freeproxy.com/uk-proxy.html',
    'https://2freeproxy.com/canada-proxy.html',
    'https://2freeproxy.com/france-proxy.html'
  ]

  def parse
    result = []

    LINKS.each do |link|
      doc = Nokogiri::HTML(open(link))
      result << doc.css('p')[3].text.squish.split(' ')
    end

    result.flatten!
    result.uniq!
    result
  end
end
