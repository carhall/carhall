class CreateMendingOrderInfos < ActiveRecord::Migration
  def change
    create_table :mending_order_infos do |t|
      t.references :source
      t.float    :price
      t.integer  :brand_id
      t.string   :series
      t.string   :plate_num
      t.datetime :arrive_at
      t.text     :description
      
    end
    
    add_index :mending_order_infos, :source_id
  end
end
