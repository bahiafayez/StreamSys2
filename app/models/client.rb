class Client < ActiveRecord::Base
  belongs_to :proxy #, :dependent => :destroy #dependent so that when user
  belongs_to :resulting_stream
  belongs_to :user
  
  
  
end
