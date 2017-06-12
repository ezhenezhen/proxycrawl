class ProxyDb
  # http://proxydb.net/?offset=2000 offset every 50
  # http://proxydb.net/?offset=0 first page
  LINK = 'http://proxydb.net/?offset='

  def parse
    result = []

    (0..40).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n*50}"))
      doc.css('table.table.table-sm tbody tr td a').each do |node|
        result << node.text
      end
    end

    result.uniq!
    result
  end
end
