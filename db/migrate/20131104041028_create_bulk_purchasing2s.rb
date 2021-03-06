class CreateBulkPurchasing2s < ActiveRecord::Migration
  def change
    create_table :bulk_purchasing2s do |t|
      t.references :distributor, index: true
      t.references :location, index: true
      t.integer :area_id
      t.index   :area_id

      t.string   :title
      t.integer  :bulk_purchasing_type_id
      t.index    :bulk_purchasing_type_id

      t.datetime :expire_at
      t.index    :expire_at

      t.float    :price
      t.index    :price

      t.float    :vip_price
      t.index    :vip_price

      t.integer  :inventory
      t.text     :description
      t.attachment :image
      
      t.float   :total_cost
      t.index   :total_cost
      t.integer :orders_count, default: 0
      t.index   :orders_count

      t.timestamps

    end
  end
end
