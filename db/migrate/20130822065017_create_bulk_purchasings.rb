class CreateBulkPurchasings < ActiveRecord::Migration
  def change
    create_table :bulk_purchasings do |t|
      t.references :dealer
      t.references :dealer_detail
      t.string   :title
      t.integer  :bulk_purchasing_type_id
      t.datetime :expire_at
      t.float    :price
      t.float    :vip_price
      t.text     :description
      t.integer  :orders_count, default: 0
      t.attachment :image
      
      t.timestamps
    end

   add_index :bulk_purchasings, :orders_count

  end
end
