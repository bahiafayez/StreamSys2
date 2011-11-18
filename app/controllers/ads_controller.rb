class AdsController < ApplicationController
  
  def index
    @title = "All Advertisements"
    @ads = Ad.paginate(:page => params[:page])
  end
  

  

end
