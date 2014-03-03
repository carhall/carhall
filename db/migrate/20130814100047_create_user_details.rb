class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.string  :series
      t.string  :plate_num
      t.integer :balance, null: false, default: 0
      t.attachment :image

    end
    
  end
end
