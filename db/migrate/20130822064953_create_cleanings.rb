class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.references :dealer
      t.string  :title
      t.integer :cleaning_type_id
      t.float   :price
      t.float   :vip_price
      t.text    :description
      t.integer :cleaning_orders_count
      t.attachment :image
      
      t.timestamps
    end

  end
end
