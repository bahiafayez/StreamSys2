class StreamPlaylist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :resulting_stream
end
