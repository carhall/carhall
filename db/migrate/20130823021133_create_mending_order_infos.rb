class CreateMendingOrderInfos < ActiveRecord::Migration
  def change
    create_table :mending_order_infos do |t|
      t.references :source
      t.integer  :price
      t.integer  :brand_id
      t.string   :plate_num
      t.datetime :arrive_at
      t.integer  :mending_type
      
    end
    
    add_index :mending_order_infos, :source_id

    Mending.create!(dealer: Dealer.first)
  end
end
