class ResultingStream < ActiveRecord::Base
  has_many :live_streams
  has_many :proxies
  belongs_to :client
  
  has_many :playlists, :dependent => :destroy
  has_many :ads, :through => :playlists
end
