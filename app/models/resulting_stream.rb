class ResultingStream < ActiveRecord::Base
  belongs_to :live_stream
  belongs_to :proxy
  has_many :clients
  
  has_many :stream_playlists, :dependent => :destroy
  has_many :playlists, :through => :stream_playlists
end
