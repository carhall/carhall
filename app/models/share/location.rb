class Share::Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude

  validates_presence_of :latitude, :longitude
  
  before_save do
    self.geohash = Geohash.encode(latitude, longitude)
  end

  attr_reader :distance

  def set_distance lat, lng
    @distance = Math.sqrt((latitude-lat)**2 + (longitude-lng)**2)
  end

end