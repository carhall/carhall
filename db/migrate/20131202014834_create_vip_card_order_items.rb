class CreateVipCardOrderItems < ActiveRecord::Migration
  def change
    create_table :vip_card_order_items do |t|
      t.references :vip_card_order
      t.references :source
      t.string  :title
      t.integer :state_id, default: 1
      t.index   :state_id

      t.float   :cost
      t.integer :count, default: 0
      t.integer :used_count, default: 0
      
      t.boolean :has_review, default: false
    end
  end
end
