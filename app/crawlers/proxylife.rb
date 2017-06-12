class Proxylife
  LINK = 'http://proxylife.org/proxy/http'

  VOCABULARY = {
    '46' => '.', 
    '58' => ':'
  }
  
  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))
    doc.css('div.entry.fix').each do |node|
      result << node.children[9].text 
    end

    result.uniq!
    result
  end

  private 

  def translate_text(text_to_translate)
    text = ''

    if text_to_translate('-')
      text_to_translate.split('-').each do |symbol|
        text += VOCABULARY[symbol] unless VOCABULARY[symbol].nil?
      end
    end 

    text
  end 
end