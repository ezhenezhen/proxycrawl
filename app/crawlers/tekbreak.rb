class Tekbreak
  # http://proxy.tekbreak.com/{n}/{mode}
  LINK = 'http://proxy.tekbreak.com/200/html'

  def parse
    result = []
    doc = Nokogiri::HTML(open(LINK))
    doc.css('body div').each do |node|
      puts node.children.first.text + ':' + node.children[2].text
    end

    result
  end
end
