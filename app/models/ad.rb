class Ad < ActiveRecord::Base
  has_many :playlists, :dependent => :destroy
  has_many :resulting_streams, :through => :playlists
  
  has_many :ad_types, :dependent => :destroy
  has_many :categories, :through => :ad_types
end
