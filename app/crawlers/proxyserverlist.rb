class Proxyserverlist
  LINK = 'http://proxyserverlist-24.blogspot.com/'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    links_to_parse = []

    doc.css('h3.post-title').each do |node|
      links_to_parse << node.children[1].attributes['href'].value
    end

    links_to_parse.each do |link|
      doc = Nokogiri::HTML(open(link))
      result << doc.css('pre.alt2').text.squish.split(' ')
    end

    result.flatten!
    result
  end
end