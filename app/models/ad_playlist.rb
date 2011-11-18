class AdPlaylist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :ad
end
