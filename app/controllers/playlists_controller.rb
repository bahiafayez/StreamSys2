class PlaylistsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    #for showing existing playlists.. and creating new ones.
    @title = "All Playlists"
    @playlists = Playlist.paginate(:page => params[:page])
  end

  def show
    @playlist = Playlist.find(params[:id])
    @ads = @playlist.ad_playlists.paginate(:page => params[:page])
    @title = @playlist.name
  end
  
  def new
    @title ="Create Playlist"
    #@playlist=Playlist.new
    #@ads=Ad.all
    session[:ad_params] ||= {}
    session[:choice_params] ||= {}
    session[:search_params] ||= {}
    #session[:sort_params]||={}
    #session[:direction_params]||={}
    
    #session[:ad_params].deep_merge!(params[:playlist]) if params[:playlist]
    #session[:choice_params]=params[:choice]
    logger.debug 'HERE IN NEW ACTION!!!!!!'
    logger.debug params[:choice]
    @playlist = Playlist.new(session[:ad_params])
    @playlist.current_step = session[:ad_step]
    session[:what]=true
    #@cats=Category.all
    params[:search]||= session[:search_params]
    #params[:sort]||=session[:sort_params]
    #params[:direction]||=session[:direction_params]
    @advertisements = Ad.search(params[:search]).order(sort_column + " " + sort_direction)#.paginate(:per_page => 5, :page => params[:page])
   logger.debug 'ads areeeeee '
   logger.debug @advertisements
  end
  
  
  # def create
    # @playlist = Playlist.new(params[:playlist])
    # if @playlist.save
      # # Handle a successful save.
      # #sign_in2 @user #method in sessions_helper
      # flash[:success] = "Welcome to the Sample App!"
      # @ads= params[:choice]
      # logger.debug "HEREEEEEEEEEEEEEEEEEEEEEEEEE"
      # logger.debug params[:choice]
      # for x in params[:choice]
        # logger.debug x[0]
        # @ad = AdPlaylist.new(:playlist_id => @playlist.id, :ad_id => x[0])
        # @ad.save
      # end
      # render 'new2'
    # else
      # #@title = "Sign up"
      # render 'new'
    # end
  # end
  def create
  logger.debug 'search button'
  logger.debug params[:search_button] 
  logger.debug session[:ad_params]
  logger.debug params[:choice]

  
  logger.debug "HEREEEEEEEEEEEEEEEEEEEEEEEEE"
  logger.debug session[:ad_params]
  logger.debug session[:choice_params]
  @playlist = Playlist.new(session[:ad_params])
  if params[:search_button]
   
    @playlist = Playlist.new(session[:ad_params])
    @playlist.current_step = session[:ad_step]
    @advertisements = Ad.search(params[:search]).order(sort_column + " " + sort_direction)#.paginate(:per_page => 5, :page => params[:page])
    session[:ad_params].deep_merge!(params[:playlist]) if params[:playlist]
    session[:choice_params].merge(params[:choice]) if params[:choice]
    session[:search_params]=params[:search]
    render "new"
  else
  
  
  
  session[:ad_params].deep_merge!(params[:playlist]) if params[:playlist]
  session[:choice_params]=params[:choice] if session[:what]
  #@ads=Ad.all
  @advertisements = Ad.search(params[:search]).order(sort_column + " " + sort_direction)#.paginate(:per_page => 5, :page => params[:page])
  @playlist.current_step = session[:ad_step]
  if @playlist.valid?
    if params[:back_button]
      @playlist.previous_step
    elsif @playlist.last_step?
      @playlist.save if @playlist.all_valid?
      #also save Ad playlist
      
      for x in params[:text]
       logger.debug 'testing hereeeeeee'
      logger.debug x[0]
      logger.debug x[1]
      @cat = AdPlaylist.new(:playlist_id => @playlist.id, :ad_id => x[0], :time=>x[1])
      @cat.save
      end
      
    else
      @playlist.next_step
    end
    session[:ad_step] = @playlist.current_step
  end
  if @playlist.first_step?
    session[:what]=true
  else
    session[:what]=false
  end
  if @playlist.current_step== "time"
    @times=Array.new
    for x in session[:choice_params]
      
      logger.debug 'in new if!!!!!!!!!!!'
      logger.debug x[0]
      @times.push(Ad.find(x[0]))
      #logger.debug @advertisements
    end
  end
  if @playlist.new_record?
    render "new"
  else
    session[:ad_step] = session[:ad_params] = session[:choice_params]= nil
    flash[:notice] = "Playlist saved!"
    redirect_to @playlist
  end
  
 end
  
  
  end
  
   def destroy
    @playlist=Playlist.find(params[:id])
    @playlist.destroy
    redirect_to "/playlists/index"
   end
  
  private
  
  def sort_column
    Ad.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  
end

