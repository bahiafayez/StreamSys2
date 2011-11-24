class AdsController < ApplicationController
  
  def index
    @title = "All Advertisements"
    @ads = Ad.paginate(:page => params[:page])
  end
  
  def new
    @title ="Add Advertisements"
    @ad=Ad.new
    @cats=Category.all
  end
  
  def create
    @ad = Ad.new(params[:ad])
    
      
    
    #@categories.each do |c|
      #@cat = AdType.new(:ad_id => @ad.id, :category_id => params[:cats][])
      #@cat.save
   #end
    
    #This is equivalent to:
    #@user = User.new(:name => "Foo Bar", :email => "foo@invalid",
                 #:password => "dude", :password_confirmation => "dude")
    if @ad.save
      # Handle a successful save.
      #sign_in2 @user #method in sessions_helper
      flash[:success] = "Welcome to the Sample App!"
      @categories= params[:cats]
    logger.debug "HEREEEEEEEEEEEEEEEEEEEEEEEEE"
    logger.debug params[:cats]
    for x in params[:cats]
      logger.debug x[0]
      @cat = AdType.new(:ad_id => @ad.id, :category_id => x[0])
      @cat.save
    end
      redirect_to @ad
    else
      #@title = "Sign up"
      render 'new'
    end
  end
  
  def show
    #What this means in the context of users—which we’re now thinking 
    #of as a Users resource—is that we should view the user with id 1 
    #by issuing a GET request to the URL /users/1. Here the show action 
    #is implicit in the type of request—when Rails’ REST features are 
    #activated, GET requests are automatically handled by the show action.
    respond_to do |format|
      format.html do
        @ad = Ad.find(params[:id])
        @title = @ad.name
      end
      format.json do
        #@post = "hey there"
        #@user = User.find(params[:id])
        #render :json => @user
      end
    end
  end
  

  

end
