class Socks::HidemyName
  def parse
    result = []

    result << socks4
    result << socks5

    result.flatten!
    result
  end

  def socks4
    link = 'https://hidemy.name/en/proxy-list/?type=4&start='
    get_ips(link)
  end

  def socks5
    link = 'https://hidemy.name/en/proxy-list/?type=5&start='
    get_ips(link)
  end

  def get_ips(link)
    result = []
    (0..5).each do |n|
      doc = Nokogiri::HTML(open("#{link}#{n*64}"))
      doc.css('tr').each do |node|
        if node.css('td').count > 0
          result << node.css('td').first.text + ':' + node.css('td')[1].text
        end
      end
    end

    result.uniq!
  end
end
