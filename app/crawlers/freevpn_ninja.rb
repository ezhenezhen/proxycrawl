class FreevpnNinja
  LINK = 'https://freevpn.ninja/free-proxy/json'
 
  def parse
    result = []
   
    doc = Nokogiri::HTML(open(LINK))
    
    parsed = JSON.parse doc.children[1]
    parsed.each do |proxy|
      result << proxy['proxy']
    end
 
    result.uniq!
    result
  end

  def socks4
  end

  def socks5
  end
end
