class CreateVipCardItems < ActiveRecord::Migration
  def change
    create_table :vip_card_items do |t|
      t.references :vip_card, index: true

      t.string   :title
      t.float    :price
      t.index    :price

      t.integer  :count
      
    end
  end
end
