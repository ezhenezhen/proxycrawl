class Awmproxy
  LINK = 'http://awmproxy.com/freeproxy.php'

  def parse
    result = []
    
    doc = Nokogiri::HTML(open(LINK))

    browser = Watir::Browser.new :chrome
    browser.goto LINK
    html = browser.html
    browser.close

    doc = Nokogiri::HTML(html)

    doc.css('tbody tr').each do |node|
      result << node.children.first.text
    end

    result.uniq!
    result
  end
end
