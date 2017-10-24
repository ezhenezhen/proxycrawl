class Socks::Socklist
  LINK = 'https://sockslist.net/proxy/server-socks-hide-ip-address/'

  def parse
    result = []
    10.times do
      (1..4).each do |n|
        doc = Nokogiri::HTML(open(LINK + n.to_s))

        doc.css('tr').each do |node|
          if node.children[1].text && node.children[3].text
            ip = node.children[1].text
            port = node.children[3].text[/\d+/]

            result << ip + ':' + port.to_s
          end
        end
      end
    end

    result.uniq!
    result.shift(2)
    result
  end
end
