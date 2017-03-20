class Tekbreak
  # http://proxy.tekbreak.com/{n}/{mode}
  LINK = 'http://proxy.tekbreak.com/200/json'

  def parse
    result = []
    doc = Nokogiri::HTML(open(LINK))
    json = JSON.parse(doc)

    json.each do |j|
      result << j['ip'] + ':' + j['port']
    end

    result
  end
end
