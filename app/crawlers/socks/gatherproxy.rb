class Socks::Gatherproxy
  # ports are stored as hex 16
  LINK = 'http://www.gatherproxy.com/ru/sockslist'

  def parse
    result = []
    result << socks5
    result.flatten!
    
    result
  end

  def socks5
    get_ips
  end

  def get_ips
    result = []
    
    doc = Nokogiri::HTML(open(LINK))

    doc.css('script').each_with_index do |s, index|
      if s.text.include?('document.write')
        if s.text.split('(').second.include?('.')
          proxy = s.text.to_s.squish.split('(').second + doc.css('script')[index + 1].text.split('(').second
          proxy.gsub!("')'", ':')
          proxy.gsub!("')", '')
          proxy.gsub!("'", '')
          result << proxy
        end
      end
    end

    result.uniq!
    result
  end
end
