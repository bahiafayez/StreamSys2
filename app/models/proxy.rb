class Proxy < ActiveRecord::Base
  belongs_to :resulting_stream
  belongs_to :client
end
