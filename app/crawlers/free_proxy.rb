class FreeProxy
  LINKS = [
    'http://free-proxy.cz/en/proxylist/main/', 
    'http://free-proxy.cz/en/proxylist/main/speed/', 
    'http://free-proxy.cz/en/proxylist/main/uptime/', 
    'http://free-proxy.cz/en/proxylist/main/ping/', 
    'http://free-proxy.cz/en/proxylist/main/date/'
  ]

  def parse
    result = []

    LINKS.each do |link|
    # only 9 pages without captcha
      (1..9).each do |n|
        doc = Nokogiri::HTML(open("#{link}#{n}"))
        doc.css('tbody tr').each do |node|
          nodeText = node.children[0].text
          if nodeText['document.write']
            result << Base64.decode64(nodeText.split("(").last) + ':' + node.children[1].children.text
          end
        end
      end
    end

    result.uniq!
    result
  end

  def socks4
    link = 'http://free-proxy.cz/en/proxylist/country/all/socks4/speed/all'
  end

  def socks5
    link = 'http://free-proxy.cz/en/proxylist/country/all/socks5/speed/all'
  end
end
