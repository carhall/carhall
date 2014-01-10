class CreateTrafficReports < ActiveRecord::Migration
  def change
    create_table :traffic_reports do |t|
      t.references :user
      t.references :at_user
      t.references :provider, index: true
      t.text :content
      t.attachment :image
      
      t.float  :latitude, limit: 32
      t.float  :longitude, limit: 32
      t.string :geohash
      t.index  :geohash
      
      t.timestamps
    end
  end
end
