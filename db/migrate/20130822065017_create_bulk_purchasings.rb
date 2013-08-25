class CreateBulkPurchasings < ActiveRecord::Migration
  def change
    create_table :bulk_purchasings do |t|
      t.references :dealer
      t.string   :title
      t.datetime :expire_at
      t.string   :typehood
      t.integer  :price
      t.integer  :vip_price
      t.text     :description
      t.integer  :bulk_purchasing_orders_count
      t.attachment :image
      
      t.timestamps
    end

  end
end
