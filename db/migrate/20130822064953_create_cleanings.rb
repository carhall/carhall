class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.references :dealer
      t.references :location
      t.integer :area_id

      t.string  :title
      t.integer :cleaning_type_id
      t.float   :price
      t.float   :vip_price
      t.text    :description
      t.attachment :image
      
      t.float   :total_sale

      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0
      t.integer :stars_count, default: 0

      t.timestamps
    end

    change_table :cleanings do |t|
      t.index :dealer_id
      t.index :location_id
      t.index :area_id

      t.index :cleaning_type_id

      t.index :price
      t.index :vip_price
      
      t.index :total_sale

      t.index :orders_count
      t.index :reviews_count
      t.index :stars_count
      
    end

  end
end
