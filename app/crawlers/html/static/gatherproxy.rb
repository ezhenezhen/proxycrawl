class Html::Static::Gatherproxy
  # ports are stored as hex 16
  LINK = 'http://www.gatherproxy.com/'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))

    doc.css('script').each do |s|
      if s.text.include?('PROXY_IP')
        json = JSON.parse(s.text.split('(').second.split(')').first)
        result << json['PROXY_IP'] + ':' + json['PROXY_PORT'].hex.to_s
      end
    end

    result.uniq!
    result
  end
end
