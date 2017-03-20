class Tekbreak
  # http://proxy.tekbreak.com/{n}/{mode}
<<<<<<< HEAD
  LINK = 'http://proxy.tekbreak.com/200/html'
=======
  LINK = 'http://proxy.tekbreak.com/200/json'
>>>>>>> master

  def parse
    result = []
    doc = Nokogiri::HTML(open(LINK))
    doc.css('body div').each do |node|
      puts node.children.first.text + ':' + node.children[2].text
    end

    result
  end
end
