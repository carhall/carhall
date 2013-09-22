class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.references :dealer
      t.references :dealer_detail
      t.string  :title
      t.integer :cleaning_type_id
      t.float   :price
      t.float   :vip_price
      t.text    :description
      t.integer :orders_count, default: 0
      t.attachment :image
      
      t.timestamps
    end

   add_index :cleanings, :orders_count
   add_index :cleanings, :cleaning_type_id
   
  end
end
