class Hidester
  LINK = 'https://hidester.com/proxylist/'

  def parse
   result = []

   browser = Watir::Browser.new :phantomjs
   browser.goto LINK 
   html = browser.html
   browser.close

   doc = Nokogiri::HTML(html)
   doc.css('tr').each do |node|
     puts node.text
   end
    
   result
 end
end
