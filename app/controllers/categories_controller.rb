class CategoriesController < ApplicationController
  def index
    @title = "All Categories"
    @categories = Category.paginate(:page => params[:page])
  end

  def new
    @title ="Add Categories"
    @category=Category.new
  end

  def create
    @cat = Category.new(params[:category])
    
    if @cat.save
      # Handle a successful save.
      #sign_in2 @user #method in sessions_helper
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @cat
    else
      @title = "Add Categories"
      render 'new'
    end
  end
  
  def show
    @cat = Category.find(params[:id])
    @title = @cat.name
  end

end
