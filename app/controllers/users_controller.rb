class UsersController < ApplicationController
  
  #before_filter :authenticate, :only => [:index, :edit, :update]
  
  before_filter :authenticate, :except => [:new, :create]
  # to make sure you are signed in before editing/updating
  before_filter :correct_user, :only => [:edit,:show, :update]
  # to make sure you are the right user
  before_filter :admin_user,   :only => :destroy
  # to make sure only admins can delete
  
  
  def new
    @title = "Sign up"
    @user= User.new
  end
  
  # def index
   # # @title = "All users"
   # # @users = User.paginate(:page => params[:page])
  # end
#   
  def show
    #What this means in the context of users—which we’re now thinking 
    #of as a Users resource—is that we should view the user with id 1 
    #by issuing a GET request to the URL /users/1. Here the show action 
    #is implicit in the type of request—when Rails’ REST features are 
    #activated, GET requests are automatically handled by the show action.
    respond_to do |format|
      format.html do
        @user = User.find(params[:id])
        #@microposts = @user.microposts.paginate(:page => params[:page])
        @title = @user.username
      end
      format.json do
        #@post = "hey there"
        @user = User.find(params[:id])
        render :json => @user
      end
    end
  end
  def create
    @user = User.new(params[:user])
    #This is equivalent to:
    #@user = User.new(:name => "Foo Bar", :email => "foo@invalid",
                 #:password => "dude", :password_confirmation => "dude")
    if @user.save
      # Handle a successful save.
      sign_in2 @user #method in sessions_helper
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
#   
  # def edit
    # #@user = User.find(params[:id])
    # # removed because the before filter already sets the user.. for 
    # # edit and update.
    # @title = "Edit user"
  # end
#   
  # def update
    # @user = User.find(params[:id])
    # if @user.update_attributes(params[:user])  #like user.save but updates instead.
      # flash[:success] = "Profile updated."
      # redirect_to @user #if won't redirect then use Flash.now instead
    # else
      # @title = "Edit user"
      # render 'edit'
    # end
  # end
#   
  # def destroy
    # User.find(params[:id]).destroy
    # flash[:success] = "User destroyed."
    # redirect_to users_path
  # end
#   
#   
  # def following
    # @title = "Following"
    # @user = User.find(params[:id])
    # @users = @user.following.paginate(:page => params[:page])
    # render 'show_follow'
  # end
# 
  # def followers
    # @title = "Followers"
    # @user = User.find(params[:id])
    # @users = @user.followers.paginate(:page => params[:page])
    # render 'show_follow'
  # end
#   
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
