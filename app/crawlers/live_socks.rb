class LiveSocks
  LINK = 'http://www.live-socks.net/'

  def parse
    result = []

    doc = Nokogiri::HTML(open(LINK))

    result
  end
end



# require 'watir-webdriver'
# b = Watir::Browser.new
# b.goto('http://www.hollisterco.com/webapp/wcs/stores/servlet/TrackDetail?storeId=10251&catalogId=10201&langId=-1&URL=TrackDetailView&orderNumber=1316358')
# puts b.h3(:class, 'order-num').when_present.text
