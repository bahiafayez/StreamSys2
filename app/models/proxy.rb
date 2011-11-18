class Proxy < ActiveRecord::Base
  has_many :resulting_streams
  has_many :clients
end
