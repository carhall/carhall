class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.references :dealer, index: true
      t.references :location, index: true
      t.integer :area_id
      t.index   :area_id

      t.string  :title
      t.integer :cleaning_type_id
      t.index   :cleaning_type_id

      t.float   :price
      t.index   :price

      t.float   :vip_price
      t.index   :vip_price
      
      t.text    :description
      t.attachment :image
      
      t.float   :total_cost
      t.index   :total_cost

      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0
      t.integer :stars_count, default: 0
      t.index   :orders_count
      t.index   :reviews_count
      t.index   :stars_count

      t.timestamps
    end
    
  end
end
