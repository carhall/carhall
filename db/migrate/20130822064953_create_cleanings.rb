class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.references :dealer
      t.string  :title
      t.string  :typehood
      t.integer :price
      t.integer :vip_price
      t.text    :description
      t.integer :cleaning_orders_count
      t.attachment :image
      
      t.timestamps
    end

  end
end
