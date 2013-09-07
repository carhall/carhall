class CreateBulkPurchasings < ActiveRecord::Migration
  def change
    create_table :bulk_purchasings do |t|
      t.references :dealer
      t.string   :title
      t.datetime :expire_at
      t.integer  :bulk_purchasing_type_id
      t.float    :price
      t.float    :vip_price
      t.text     :description
      t.integer  :bulk_purchasing_orders_count
      t.attachment :image
      
      t.timestamps
    end

  end
end
