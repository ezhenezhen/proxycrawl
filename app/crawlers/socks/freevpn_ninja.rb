class Socks::FreevpnNinja
  LINK = 'https://freevpn.ninja/free-proxy/json'
 
  def parse
    result = []
    result << socks4
    result << socks5

    result
  end

  def socks4
    get_ips(:socks4)
  end

  def socks5
    get_ips(:socks5)
  end

  def get_ips(type)
    result = []
    doc = Nokogiri::HTML(open(LINK))
    
    parsed = JSON.parse doc.children[1]
    parsed.each do |proxy|
      result << proxy['proxy'] if proxy['type'] == type.to_s
    end

    result
  end
end
