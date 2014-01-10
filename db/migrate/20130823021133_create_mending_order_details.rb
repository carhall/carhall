class CreateMendingOrderDetails < ActiveRecord::Migration
  def change
    create_table :mending_order_details do |t|
      t.integer  :brand_id
      t.index    :brand_id

      t.string   :series
      t.string   :plate_num
      t.datetime :arrive_at
      t.integer  :mending_type_id
      t.index    :mending_type_id
      
      t.text     :description
    end
    
  end
end
