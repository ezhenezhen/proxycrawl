class CoolProxy
  LINK = 'https://www.cool-proxy.net/proxies?page='

  def parse
    result = []

    (1..11).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))

      doc.css('tr').each do |node|
        if node.children[1].children[0].children[2] && node.children[3]
          ip = node.children[1].children[0].children[2].text + '.' + node.children[1].children[0].children[4].text + '.' + node.children[1].children[0].children[7].text + '.' + node.children[1].children[0].children[11].text
          port = node.children[3].text

          result << ip + ':' + port
        end
      end
    end

    result
  end
end
