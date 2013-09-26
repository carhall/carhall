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

    end

    change_table :user_details do |t|
      t.index [:area_id, :brand_id]
      
    end
    
  end
end
