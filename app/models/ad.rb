class Ad < ActiveRecord::Base
  has_many :ad_playlists, :dependent => :destroy
  has_many :playlists, :through => :ad_playlists
  
  has_many :ad_types, :dependent => :destroy
  has_many :categories, :through => :ad_types
  
  
  def self.search(search)
    if search
      where( 'name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
