class Samair
  LINK = 'http://samair.ru/proxy/'

  def initialize
  end

  def parse
    result = []
    doc = Nokogiri::HTML(open('http://samair.ru/ru/proxy/'))
    doc.css('div#content table#proxylist tr td:first-child').each do |node|
      result << node.text
    end

    result
  end
end
