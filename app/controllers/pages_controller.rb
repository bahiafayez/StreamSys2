class PagesController < ApplicationController
  respond_to :html, :xml
  def home
    @title = "Home"
    #@micropost = Micropost.new if signed_in?
    #if signed_in?
    #  @micropost = Micropost.new
    #  @feed_items = current_user.feed.paginate(:page => params[:page])
      # current user is in sessions_helpser
      # feed is in user.rb since current user returns a user
    #end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end 
  

end