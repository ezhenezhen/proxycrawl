class Html::Ultraproxies
  LINKS = [
    'http://www.ultraproxies.com',
    'http://www.ultraproxies.com/index.html?lastSort=tested&descending=%20desc&order=chg&sort=seconds',
    'http://www.ultraproxies.com/index.html?lastSort=seconds&descending=&order=chg&sort=tested',
    'http://www.ultraproxies.com/index.html?lastSort=tested&descending=%20desc&order=chg&sort=orgname',
    'http://www.ultraproxies.com/index.html?lastSort=orgname&descending=&order=chg&sort=orgname',
    'http://www.ultraproxies.com/index.html?lastSort=orgname&descending=%20desc&order=chg&sort=country',
    'http://www.ultraproxies.com/index.html?lastSort=country&descending=&order=chg&sort=country',
    'http://www.ultraproxies.com/index.html?lastSort=country&descending=%20desc&order=chg&sort=cityname',
    'http://www.ultraproxies.com/index.html?lastSort=cityname&descending=&order=chg&sort=cityname',
    'http://www.ultraproxies.com/index.html?lastSort=cityname&descending=%20desc&order=chg&sort=anonlvl',
    'http://www.ultraproxies.com/index.html?lastSort=anonlvl&descending=&order=chg&sort=anonlvl',
    'http://www.ultraproxies.com/index.html?lastSort=anonlvl&descending=%20desc&order=chg&sort=port',
    'http://www.ultraproxies.com/index.html?lastSort=port&descending=&order=chg&sort=port',
    'http://www.ultraproxies.com/index.html?lastSort=port&descending=%20desc&order=chg&sort=ip',
    'http://www.ultraproxies.com/index.html?lastSort=ip&descending=&order=chg&sort=ip'
  ]

  VOCABULARY = {
    '65' => '0',
    '66' => '1',
    '67' => '2',
    '68' => '3',
    '69' => '4',
    '70' => '5',
    '71' => '6',
    '72' => '7',
    '73' => '8',
    '74' => '9'
  }
 
  def parse
    result = []
    
    LINKS.each do |link|
      doc = Nokogiri::HTML(open(link))

      doc.css('table.main>tr')[3].children[4].children[5].children.each do |node|
        if node.children[0] && node.children[1]
          result << node.children[0].text + translate_port(node.children[1].text)
        end
      end
    end
 
    result.uniq!
    result.delete('\n\n\t')
    
    result
  end

  private

  def translate_port(port_to_translate)
    port = ''

    if port_to_translate.include?('-')
      port_to_translate.split('-').each do |symbol|
        port += VOCABULARY[symbol] unless VOCABULARY[symbol].nil?
      end
    end

    port
  end
end
