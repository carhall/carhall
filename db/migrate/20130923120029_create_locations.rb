class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float  :latitude, limit: 32
      t.float  :longitude, limit: 32
      t.string :geohash
      t.index  :geohash
    
    end
  end
end
