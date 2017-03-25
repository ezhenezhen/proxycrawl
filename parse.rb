proxies.each do |proxy|
  ip = proxy['ip'].squish
  port = proxy['port'].squish
  site = proxy['site']

  if Proxy.where(ip: ip, port: port, site: site).blank? && IPAddress.valid?(ip)
    Proxy.create(
      ip: ip,
      port: port, 
      site: site
    )
  end
end
