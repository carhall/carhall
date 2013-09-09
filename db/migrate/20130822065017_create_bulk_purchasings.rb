class CreateBulkPurchasings < ActiveRecord::Migration
  def change
    create_table :bulk_purchasings do |t|
      t.references :dealer
      t.string   :title
      t.integer  :bulk_purchasing_type_id
      t.datetime :expire_at
      t.float    :price
      t.float    :vip_price
      t.text     :description
      t.integer  :bulk_purchasing_orders_count
      t.attachment :image
      
      t.timestamps
    end

  end
end
