class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.references :dealer, index: true
      
      t.string :username
      t.index  :username

      t.string :mobile
      t.index  :mobile

      t.string :plate_num
      t.index  :plate_num

      t.string :brand
    end
  end
end
