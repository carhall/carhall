class CreateVipCardItems < ActiveRecord::Migration
  def change
    create_table :vip_card_items do |t|
      t.references :vip_card, index: true

      t.string   :title
      t.float    :price, index: true
      t.integer  :count
      
    end
  end
end
