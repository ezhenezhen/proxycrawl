class Socks::FreeProxy
  def parse
    result = []
    result << socks4
    result << socks5
    result
  end

  def socks4
    link = 'http://free-proxy.cz/en/proxylist/country/all/socks4/speed/all/'
    socks4 = get_ips(link)
    socks4
  end

  def socks5
    link = 'http://free-proxy.cz/en/proxylist/country/all/socks5/speed/all/'
    socks5 = get_ips(link)
    socks5
  end

  def get_ips(link)
    result = []

    (1..5).each do |n|
      doc = Nokogiri::HTML(open("#{link}#{n}"))
      doc.css('tboody tr').each do |node|
        nodeText = node.children[0].text
        if nodeText['document.write']
          result << Base64.decode64(nodeText.split("(").last) + ':' + node.children[1].children.text
        end
      end
    end

    result.uniq!
    result
  end
end
