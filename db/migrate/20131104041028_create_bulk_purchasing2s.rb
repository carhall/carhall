class CreateBulkPurchasing2s < ActiveRecord::Migration
  def change
    create_table :bulk_purchasing2s do |t|
      t.references :distributor, index: true
      t.references :location, index: true
      t.integer :area_id, index: true

      t.string   :title
      t.integer  :bulk_purchasing_type_id, index: true
      t.datetime :expire_at, index: true
      t.float    :price, index: true
      t.float    :vip_price, index: true
      t.integer  :inventory
      t.text     :description
      t.attachment :image
      
      t.float   :total_cost, index: true
      t.integer :orders_count, default: 0, index: true

      t.timestamps

    end
  end
end
