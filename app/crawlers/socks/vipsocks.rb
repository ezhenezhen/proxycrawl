class Socks::Vipsocks
  LINK = 'http://www.vipsocks24.net/'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    links_to_parse = []

    doc.css('h3.post-title').each do |node|
      links_to_parse << node.children[1].attributes['href'].value
    end

    links_to_parse.each do |link|
      doc = Nokogiri::HTML(open(link))
      result << doc.css('textarea').text.squish.split(' ')
    end

    result.flatten!
    result.uniq!
    result
  end
end
