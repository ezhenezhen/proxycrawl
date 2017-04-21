class CrawlersController < ApplicationController
  require 'csv'
  before_action :set_crawler, only: [:show, :edit, :update, :destroy]

  # GET /crawlers
  def index
    @crawlers = Crawler.where(is_active: true).order(:name)
    @proxies_count = Proxy.count
  end

  # GET /crawlers/1
  def show
  end

  # GET /crawlers/new
  def new
    @crawler = Crawler.new
  end

  # GET /crawlers/1/edit
  def edit
  end

  # POST /crawlers
  def create
    @crawler = Crawler.new(crawler_params)

    if @crawler.save
      redirect_to @crawler, notice: 'Crawler was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /crawlers/1
  def update
    if @crawler.update(crawler_params)
      redirect_to @crawler, notice: 'Crawler was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /crawlers/1
  def destroy
    @crawler.destroy
    redirect_to crawlers_url, notice: 'Crawler was successfully destroyed.'
  end

  def file
    proxies = Proxy.where(crawler_id: params[:id])
    result = []
    proxies.each do |proxy|
      result << proxy.ip + ':' + proxy.port
    end

    send_data result.join("\n"), filename: Crawler.find(params[:id]).name + Time.now.strftime('%Y-%m-%d_%H-%M') + '.txt'
  end

  def crawl
    crawler = Crawler.find(params[:id])
    proxies = crawler.name.constantize.new.parse
    proxies_created = 0

    proxies.each do |proxy|
      ip = proxy.split(':').first.squish
      port = proxy.split(':').last.squish

      if Proxy.where(ip: ip, port: port, crawler_id: crawler.id).blank? && IPAddress.valid?(ip)
        Proxy.create(
          ip: ip,
          port: port, 
          crawler_id: crawler.id
        )
        proxies_created += 1
      end
    end

    crawler.update_column(:last_ran_at, Time.now)
    crawler.update_column(:status, proxies_created)

    proxies = Proxy.where(crawler_id: params[:id]).where('created_at >= ?', 1.week.ago)
    file_name = Crawler.find(params[:id]).name + Time.now.strftime('%Y-%m-%d_%H-%M') + '.txt'
    result = []

    proxies.each do |proxy|
      result << proxy.ip + ':' + proxy.port
    end

    file = Tempfile.new(file_name)

    File.open(file, "w+") do |f|
      result.each { |proxy| f.puts(proxy) }
    end

    RestClient.post(
      ENV['PROXY_SITE'],
      { file: File.open(file, 'r') },
      {
        'Authorization-Token' => ENV['PROXY_AUTH_TOKEN'],
        'content_type' => 'multipart/form-data'
      }
    )

    file.close
    file.unlink
    
    redirect_to root_path
    flash[:notice] = 'Successfully crawled a ' + crawler.name + '. ' + crawler.status + ' proxies added.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crawler
      @crawler = Crawler.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def crawler_params
      params.require(:crawler).permit(:name, :is_active, :status, :link, :last_ran_at, :comment)
    end
end
