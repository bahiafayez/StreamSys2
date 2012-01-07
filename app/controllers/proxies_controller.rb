class ProxiesController < ApplicationController
  def index
    @title = "All Proxies"
    @proxies = Proxy.paginate(:page => params[:page])
  end

  def new
    @title ="Add Proxies"
    @proxy=Proxy.new
  end

  def create
    @pr = Proxy.new(params[:proxy])
    
    if @pr.save
      # Handle a successful save.
      #sign_in2 @user #method in sessions_helper
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @pr
    else
      @title = "Add Proxies"
      render 'new'
    end
  end
  
  def show
   
    
    respond_to do |format|
        format.html do
            @pr = Proxy.find(params[:id])
            @title = "#{@pr.IP}:#{@pr.Port}"
        end
        format.json do
            @pr = Proxy.find(params[:id])
            render :json => ({"proxy"=>@pr})
        end
      end
      
  end


end
