class Html::Dynamic::Freeproxylists
  LINK = 'http://freeproxylists.net/?page='

  def parse
    result = []
    browser = Watir::Browser.new :chrome
    
    (1..29).each do |n|
      browser.goto(LINK + n.to_s)
     
      html = browser.html
      doc = Nokogiri::HTML(html)

      doc.css('tr').each do |node|
        if node.children[0].children[1] && node.children[1]
          ip = node.children[0].children[1].text
          port = node.children[1].text

          result << ip + ':' + port
        end
      end

      sleep 5
    end

    browser.close

    result.uniq!
    result
  end
end
