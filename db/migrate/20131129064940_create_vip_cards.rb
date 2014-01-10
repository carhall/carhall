class CreateVipCards < ActiveRecord::Migration
  def change
    create_table :vip_cards do |t|
      t.references :dealer, index: true
      t.references :location, index: true
      t.integer :area_id
      t.index   :area_id

      t.string   :title
      t.float    :price
      t.index    :price

      t.float    :vip_price
      t.index    :vip_price

      t.text     :description
      t.attachment :image

      t.integer  :position, default: 0
      t.index    :position

      t.boolean  :display, default: true
      t.index    :display
      
      t.float   :total_cost, index: true
      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0
      t.integer :stars_count, default: 0
      t.index   :orders_count
      t.index   :reviews_count
      t.index   :stars_count
      
      t.timestamps

    end
  end
end
