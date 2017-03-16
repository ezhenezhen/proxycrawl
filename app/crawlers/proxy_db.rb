class ProxyDb
  # http://proxydb.net/?offset=2000 offset every 50
  # http://proxydb.net/?offset=0 first page
  LINK = 'http://proxydb.net/'

  def parse
    result = []

    (0..40).each do |n|
      doc = Nokogiri::HTML(open("http://proxydb.net/?offset=#{n*50}"))
      doc.css('table.table.table-sm tbody tr td a').each do |node|
        result << node.text
      end
    end

    result
  end
end
