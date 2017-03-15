class CrawlersController < ApplicationController
  def index
    crawler_files = Dir['lib/crawlers/*.rb']
    @crawlers = []

    crawler_files.each do |c|
      @crawlers << File.basename(c, '.*').camelize
    end
  end

  def crawl
    @result = params[:id].constantize.new.parse
  end
end
