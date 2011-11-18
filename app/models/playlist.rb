class Playlist < ActiveRecord::Base
  has_many :stream_playlists, :dependent => :destroy
  has_many :resulting_streams, :through => :stream_playlists
  
  has_many :ad_playlists, :dependent => :destroy
  has_many :ads, :through => :ad_playlists
end
