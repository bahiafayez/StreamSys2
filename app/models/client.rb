class Client < ActiveRecord::Base
  has_many :proxies #, :dependent => :destroy #dependent so that when user
  has_many :resulting_streams
  
  has_many :preferences, :dependent => :destroy
  has_many :categories, :through => :preferences
end
