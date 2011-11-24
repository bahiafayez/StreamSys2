class Playlist < ActiveRecord::Base
  has_many :stream_playlists, :dependent => :destroy
  has_many :resulting_streams, :through => :stream_playlists
  
  has_many :ad_playlists, :dependent => :destroy
  has_many :ads, :through => :ad_playlists
  
  
  attr_writer :current_step

  #validates_presence_of :shipping_name, :if => lambda { |o| o.current_step == "shipping" }
  #validates_presence_of :billing_name, :if => lambda { |o| o.current_step == "billing" }

  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[ads time]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end
  
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
  
  def check_state
    return false
  end

end
