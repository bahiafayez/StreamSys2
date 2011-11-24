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
    session[:ad_params].deep_merge!(params[:playlist]) if params[:playlist]
    session[:choice_params]=params[:choice] 
    logger.debug 'HERE IN NEW ACTION!!!!!!'
    logger.debug params[:choice]
    @playlist = Playlist.new(session[:ad_params])
    @playlist.current_step = session[:ad_step]
    session[:what]=true
    #@cats=Category.all
    @advertisements = Ad.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
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

  session[:ad_params].deep_merge!(params[:playlist]) if params[:playlist]
  session[:choice_params]=params[:choice] if session[:what]
  logger.debug "HEREEEEEEEEEEEEEEEEEEEEEEEEE"
  logger.debug session[:ad_params]
  logger.debug session[:choice_params]
  
  @playlist = Playlist.new(session[:ad_params])
  #@ads=Ad.all
  @advertisements = Ad.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  @playlist.current_step = session[:ad_step]
  if @playlist.valid?
    if params[:back_button]
      @playlist.previous_step
    elsif @playlist.last_step?
      @playlist.save if @playlist.all_valid?
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
  if @playlist.new_record?
    render "new"
  else
    session[:ad_step] = session[:ad_params] = nil
    flash[:notice] = "Playlist saved!"
    redirect_to @playlist
  end
  
 
  
  
  end
  
  private
  
  def sort_column
    Ad.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  
end

