class Client < ActiveRecord::Base
  belongs_to :proxy #, :dependent => :destroy #dependent so that when user
  belongs_to :resulting_stream
  
  has_many :preferences, :dependent => :destroy
  has_many :categories, :through => :preferences
end
