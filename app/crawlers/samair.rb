class Samair
  LINK = 'http://samair.ru/proxy/'

  def parse
    result = []
    doc = Nokogiri::HTML(open(LINK))
    doc.css('div#content table#proxylist tr td:first-child').each do |node|
      result << node.text
    end

    result
  end
end
