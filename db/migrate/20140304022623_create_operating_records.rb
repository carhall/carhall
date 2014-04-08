class CreateOperatingRecords < ActiveRecord::Migration
  def change
    create_table :operating_records do |t|
      t.references :user, index: true
      t.references :dealer, index: true
      t.string :user_brand
      
      t.string :project
      t.string :operator
      t.string :inspector
      t.string :adviser
      
      t.string :user_mobile
      t.index  :user_mobile

      t.string :user_plate_num
      t.index  :user_plate_num

      t.timestamps
    end
  end
end
