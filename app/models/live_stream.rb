class LiveStream < ActiveRecord::Base
  has_many :resulting_streams
  
  has_many :stream_types, :dependent => :destroy
  # i think ely ta7t da is used with many-many relationships.
  has_many :categories, :through => :stream_types
  
end
