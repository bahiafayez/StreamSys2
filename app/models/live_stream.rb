class LiveStream < ActiveRecord::Base
  belongs_to :resulting_stream
  
  has_many :stream_types,
                           :dependent => :destroy
  # i think ely ta7t da is used with many-many relationships.
  has_many :categories, :through => :stream_types
  
end
