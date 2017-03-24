class ProxiesController < ApplicationController
  before_action :set_proxy, only: [:show, :edit, :update, :destroy]

  # GET /proxies
  def index
    @proxies = Proxy.paginate(page: params[:page], per_page: 100)
  end

  # GET /proxies/1
  def show
  end

  # POST /proxies
  def create
    @proxy = Proxy.new(proxy_params)

    if @proxy.save
      redirect_to @proxy, notice: 'Proxy was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proxy
      @proxy = Proxy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def proxy_params
      params.require(:proxy).permit(:site, :ip, :port)
    end
end
