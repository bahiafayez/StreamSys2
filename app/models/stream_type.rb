class StreamType < ActiveRecord::Base
  belongs_to :live_stream
  belongs_to :category
end
