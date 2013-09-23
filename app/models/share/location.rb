class Share::Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude

  validates_presence_of :latitude, :longitude
  
  before_save do
    self.geohash = Share::GeoHash.encode(latitude, longitude)
  end
end