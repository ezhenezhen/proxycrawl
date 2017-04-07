class Proxyprivat
  LINK = 'http://proxyprivat.com/freeproxies'

  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody tr').each do |node|
      result << node.children[1].text
    end

    result
  end
end
