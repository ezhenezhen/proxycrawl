class ProxyDb
  LINK = 'http://proxydb.net/'

  def initialize
  end

  def parse
    result = []
    doc = Nokogiri::HTML(open('http://proxydb.net/'))
    doc.css('table.table.table-sm tbody tr td a').each do |node|
      result << node.text
    end

    result
  end
end
