class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.references :source
      t.string  :sex
      t.integer :area_id
      t.integer :brand_id
      t.string  :series
      t.string  :plate_num
      t.integer :balance, null: false, default: 0
      t.attachment :reg_img

    end

    add_index :user_infos, [:area_id, :brand_id]
    add_index :user_infos, :source_id
  end
end
