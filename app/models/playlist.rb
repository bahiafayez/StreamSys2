class Playlist < ActiveRecord::Base
  belongs_to :resulting_stream
  belongs_to :ad
end
