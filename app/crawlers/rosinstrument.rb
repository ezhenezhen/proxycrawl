class Rosinstrument
  LINK = 'http://tools.rosinstrument.com/raw_free_db.htm?'

  def parse
    result = []
    
    (0..49).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n}"))

      result += doc.css('#content').text.split("\n")
      result.delete(" ")
    end

    result
  end
end
