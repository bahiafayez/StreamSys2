class Category < ActiveRecord::Base
  
  has_many :stream_types, :dependent => :destroy
  has_many :live_streams, :through => :stream_types
  
  has_many :preferences, :dependent => :destroy
  has_many :users, :through => :preferences
  
  has_many :ad_types, :dependent => :destroy
  has_many :ads, :through => :ad_types
  
end
