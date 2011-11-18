class PlaylistsController < ApplicationController
  
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
  
end
