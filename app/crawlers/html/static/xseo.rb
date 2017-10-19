class Html::Static::Xseo
  LINKS = ['http://xseo.in/freeproxy', 'http://xseo.in/proxylist']
  
  def parse
    result = []
    
    LINKS.each do |link|
      doc = Nokogiri::HTML(open(link))
      doc.css('td').each do |node|
        r = node.children.text.to_s.squish
        result << r unless r.blank?
      end
    end

    result.uniq!
    result
  end
end
