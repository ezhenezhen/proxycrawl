class Html::Proxynova
  MAIN_LINK = 'https://www.proxynova.com/proxy-server-list/'
  TYPES = ['port-8080/', 'port-8118/', 'port-3128/', 'port-80/', 'elite-proxies/', 'anonymous-proxies/']
  COUNTRIES = [
    'ad', 'ae', 'af', 'ag', 'ai', 'al', 'am', 'an', 'ao', 'ap', 'ar', 'as', 'at', 'au', 'aw', 'ax', 'az', 
    'ba', 'bb', 'bd', 'be', 'bf', 'bg', 'bh', 'bi', 'bj', 'bm', 'bn', 'bo', 'br', 'bs', 'bt', 'bw', 'by', 'bz', 'ca', 
    'cd', 'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm', 'cn', 'co', 'cr', 'cu', 'cv', 'cy', 'cz', 'de', 'dj', 'dk', 'dm', 
    'do', 'dz', 'ec', 'ee', 'eg', 'er', 'es', 'et', 'eu', 'fi', 'fj', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge', 'gf', 
    'gg', 'gh', 'gi', 'gl', 'gm', 'gn', 'gp', 'gq', 'gr', 'gt', 'gu', 'gw', 'gy', 'hk', 'hn', 'hr', 'ht', 'hu', 'id', 
    'ie', 'il', 'im', 'in', 'io', 'iq', 'ir', 'is', 'it', 'je', 'jm', 'jo', 'jp', 'ke', 'kg', 'kh', 'ki', 'kn', 'kp', 
    'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 'li', 'lk', 'lr', 'ls', 'lt', 'lu', 'lv', 'ly', 'ma', 'mc', 'md', 'me', 
    'mf', 'mg', 'mh', 'mk', 'ml', 'mm', 'mn', 'mo', 'mp', 'mr', 'ms', 'mt', 'mu', 'mv', 'mw', 'mx', 'my', 'mz', 'na', 
    'nc', 'ne', 'nf', 'ng', 'ni', 'nl', 'no', 'np', 'nr', 'nu', 'nz', 'om', 'pa', 'pe', 'pf', 'pg', 'ph', 'pk', 'pl', 
    'pm', 'pr', 'ps', 'pt', 'pw', 'py', 'qa', 're', 'ro', 'rs', 'ru', 'rw', 'sa', 'sb', 'sc', 'sd', 'se', 'sg', 'si', 
    'sk', 'sl', 'sm', 'sn', 'so', 'sr', 'sv', 'sy', 'sz', 'tc', 'td', 'tg', 'th', 'tj', 'tk', 'tl', 'tm', 'tn', 'to', 
    'tr', 'tt', 'tv', 'tw', 'tz', 'ua', 'ug', 'us', 'uy', 'uz', 'va', 'vc', 've', 'vg', 'vi', 'vn', 'vu', 'wf', 'ws', 
    'ye', 'za', 'zm', 'zw', 'zz'
  ]
 
  def parse
    result = []
    countries = []
    
    browser = Watir::Browser.new :chrome

    TYPES.each do |type|
      browser.goto(MAIN_LINK + type)
      html = browser.html
      
      doc = Nokogiri::HTML(html)

      doc.css('tr').each do |row|
        if row.children[1] && row.children[3]
          ip = row.children[1].text.squish.split(';').last
          port = row.children[3].text.squish
          country = doc.css('tr')[2].children[11].children[3].attributes['href'].value

          result << ip + ':' + port
        end
      end
    end

    COUNTRIES.each do |country|
      browser.goto(MAIN_LINK + 'country-' + country)
      html = browser.html
      
      doc = Nokogiri::HTML(html)

      doc.css('tr').each do |row|
        if row.children[1] && row.children[3]
          ip = row.children[1].text.squish.split(';').last
          port = row.children[3].text.squish

          result << ip + ':' + port
        end
      end
    end

    browser.close
    result.uniq!
    result
  end
end
