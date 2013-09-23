class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float  :latitude, limit: 32
      t.float  :longitude, limit: 32
      t.string :geohash
    
    end

    change_table :locations do |t|
      t.index :geohash
    end

  end
end
