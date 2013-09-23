class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.references :dealer
      t.references :location
      t.references :rating_cache
      t.integer :area_id

      t.string  :title
      t.integer :cleaning_type_id
      t.float   :price
      t.float   :vip_price
      t.text    :description
      t.integer :orders_count, default: 0
      t.attachment :image
      
      t.timestamps
    end

    change_table :cleanings do |t|
      t.index :dealer_id
      t.index :location_id
      t.index :rating_cache_id
      t.index :area_id

      t.index :orders_count
      t.index :cleaning_type_id

      t.index :price
      t.index :vip_price
      
    end

  end
end
