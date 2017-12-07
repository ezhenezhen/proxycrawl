class Rsocks
  #https://rsocks.net/freeproxy
  #Login adacer2012
  #Password adacer2012
  LINK = 'https://rsocks.net/freeproxy?page='

  def parse
    result = []

    (0..46).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))
      doc.css('table tr').each do |node|
        result << node.children[1].text + ':' + node.children[3].text
      end
    end
    
    result.uniq!
    result
  end
end

# class Rsocks
#   #https://rsocks.net/freeproxy
#   #Login: adacer2012
#   #Password: adacer2012
#   LINK = 'https://rsocks.net/freeproxy?page='

#   def parse
#     result = []

#     browser = Watir::Browser.new :chrome
#     browser.goto(LINK)
#     sleep(60)
# #    enter captcha and enter login here

#     (0..46).each do |n|
#       browser.goto("#{LINK}#{n}")
     
#       html = browser.html
#       doc = Nokogiri::HTML(html)

#       doc.css('table tr').each do |node|
#         result << node.children[1].text + ':' + node.children[3].text
#       end      
#     end

#       browser.close

#     result.uniq!
#     result
#   end
# end
