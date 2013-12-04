class CreateVipCards < ActiveRecord::Migration
  def change
    create_table :vip_cards do |t|
      t.references :dealer, index: true
      t.references :location, index: true
      t.integer :area_id, index: true

      t.string   :title
      t.float    :price, index: true
      t.float    :vip_price, index: true
      t.text     :description
      t.attachment :image

      t.integer  :position, default: 0, index: true
      t.boolean  :display, default: true, index: true
      
      t.float   :total_cost, index: true
      t.integer :orders_count, default: 0, index: true

      t.integer :reviews_count, default: 0, index: true
      t.integer :stars_count, default: 0, index: true
      
      t.timestamps

    end
  end
end