class CrawlersController < ApplicationController
  require 'csv'

  def index
    crawler_files = Dir['app/crawlers/*.rb']
    @crawlers = []

    crawler_files.each do |c|
      @crawlers << File.basename(c, '.*').camelize
    end
  end

  def show
    @proxies = Proxy.where(site: params[:id])
  end

  def file
    proxies = Proxy.where(site: params[:id])
    result = []
    proxies.each do |proxy|
      result << proxy.ip + ':' + proxy.port
    end

    send_data result.to_csv, filename: params[:id].to_s + '.txt'

    redirect_to root_path
  end

  def crawl
    proxies = params[:id].constantize.new.parse
    site = params[:id].constantize.to_s

    proxies.each do |proxy|
      ip = proxy.split(':').first
      port = proxy.split(':').last

      if Proxy.where(ip: ip, port: port, site: site).blank? && IPAddress.valid?(ip)
        Proxy.create(
          ip: ip,
          port: port, 
          site: site
        )
      end
    end

    flash.now[:notice] = 'Successfully crawled a ' + site
    @proxies = Proxy.where(site: site)
  end
end
