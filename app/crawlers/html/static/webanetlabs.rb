class Html::Static::Webanetlabs
  LINK = 'https://webanetlabs.net/publ/'

  def parse
    result = []
    links_to_parse = []

    doc = Nokogiri::HTML(open(LINK))

    doc.css('div.eTitle').each do |etitle|
      links_to_parse << etitle.children.first.attributes['href'].value.split('/').last
    end

    links_to_parse.each do |link|
      doc = Nokogiri::HTML(open(LINK + link))
      array_of_results = doc.css('td.eText').text.squish.split(' ')

      result << array_of_results
    end

    result.flatten!.delete_if { |x| !x.include?(':') }
    result.uniq!
    result
  end
end
