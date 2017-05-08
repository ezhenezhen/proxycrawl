class Proxynova
  LINK = 'https://www.proxynova.com/proxy-server-list/port-8080/'
 
  def parse
    result = []
    doc = Nokogiri::HTML(open(LINK))
    doc.css('tbody tr').each do |node|
      nodeText = node.children.children.children[0].text
      if nodeText['document']
        result << nodeText.split("(")[1].split("'")[1] + nodeText.split("(")[1].split("'")[3] + ":" + node.children.children.children[1].text
      end
    end
 
    result = []
  end
end



# Processing by CrawlersController#crawl as HTML
#   Parameters: {"id"=>"14"}
#   Crawler Load (1.0ms)  SELECT  "crawlers".* FROM "crawlers" WHERE "crawlers"."id" = $1 LIMIT $2  [["id", 14], ["LIMIT", 1]]
# Completed 500 Internal Server Error in 891ms (ActiveRecord: 1.0ms)



# TypeError - no implicit conversion of nil into String:
#   app/crawlers/proxynova.rb:10:in `block in parse'
#   nokogiri (1.7.1) lib/nokogiri/xml/node_set.rb:187:in `block in each'
#   nokogiri (1.7.1) lib/nokogiri/xml/node_set.rb:186:in `each'
#   app/crawlers/proxynova.rb:7:in `parse'
#   app/controllers/crawlers_controller.rb:62:in `crawl'
#   actionpack (5.0.2) lib/action_controller/metal/basic_implicit_render.rb:4:in `send_action'
#   actionpack (5.0.2) lib/abstract_cont
