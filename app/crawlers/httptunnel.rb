class Httptunnel
  LINK = 'http://www.httptunnel.ge/ProxyListForFree.aspx/'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))
    doc.css('div table#ctl00_ContentPlaceHolder1_GridViewNEW td:first-child').each do |node|
      result << node.text
    end

    result.uniq!
    result
  end
end
