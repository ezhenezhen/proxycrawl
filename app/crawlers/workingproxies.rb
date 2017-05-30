class Workingproxies
  # http://www.workingproxies.org/?page=39
  # http://www.workingproxies.org/?page=0
  LINK = 'http://workingproxies.org/?page='

  def parse
    result = []

    (0..39).each do |n|
      doc = Nokogiri::HTML(open("#{LINK}#{n*1}"))
      doc.css('tbody tr').each do |node|
        result << node.children.children.first.text + ':' + node.children.children[1].text
      end
    end

    result.uniq!
    result
  end
end
