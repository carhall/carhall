class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.integer :sex_id
      t.integer :area_id
      t.integer :brand_id
      t.string  :series
      t.string  :plate_num
      t.integer :balance, null: false, default: 0
      t.attachment :image

      # t.float   :total_spend

      # t.integer :orders_count, default: 0
      # t.integer :reviews_count, default: 0
      t.integer :posts_count, default: 0

    end

    change_table :user_details do |t|
      t.index [:area_id, :brand_id]

      # t.index :total_spend

      # t.index :orders_count
      # t.index :reviews_count
      t.index :posts_count
    end
    
  end
end
