class CreateBulkPurchasings < ActiveRecord::Migration
  def change
    create_table :bulk_purchasings do |t|
      t.references :dealer
      t.references :location
      t.references :rating_cache
      t.integer :area_id

      t.string   :title
      t.integer  :bulk_purchasing_type_id
      t.datetime :expire_at
      t.float    :price
      t.float    :vip_price
      t.text     :description
      t.attachment :image
      
      t.float   :stars_average
      t.float   :total_sale

      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0

      t.timestamps

    end

    change_table :bulk_purchasings do |t|
      t.index :dealer_id
      t.index :location_id
      t.index :rating_cache_id
      t.index :area_id

      t.index :bulk_purchasing_type_id

      t.index :price
      t.index :vip_price
      
      t.index :stars_average
      t.index :total_sale

      t.index :orders_count
      t.index :reviews_count
      
    end

  end
end
