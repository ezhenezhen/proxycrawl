class Rosinstrument
  LINK = 'http://tools.rosinstrument.com/raw_free_db.htm?'

  def parse
    result = []
    
    browser = Watir::Browser.new :chrome
    
    (0..49).each do |n|
      browser.goto(LINK + n.to_s)
      html = browser.html
      
      doc = Nokogiri::HTML(html)

      doc.css('tr.dbodd', 'tr.dbeven').each do |row|
        result << row.children[1].text if row.children[1]
      end
    end

    browser.close
    result.uniq!
    result
  end
end
