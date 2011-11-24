module PlaylistsHelper
  
  def check_state(ad)
    logger.debug 'in Check STATE!!!!!'
    #session[:choice_params]
    if session[:choice_params].nil?
      logger.debug 'will return false'
      return false
    else
      for x in session[:choice_params]
          #logger.debug x[0]
          #@cat = AdType.new(:ad_id => @ad.id, :category_id => x[0])
          #@cat.save
          logger.debug 'will return true'
          if ad== x[0]
            return true
          end
    
      end
     end
  return false
  end
end
