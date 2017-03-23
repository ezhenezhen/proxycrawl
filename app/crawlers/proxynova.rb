class Proxynova
  LINK = 'http://free-proxy-list.net/'

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
