class CreateTestDrivings < ActiveRecord::Migration
  def change
    create_table :test_drivings do |t|
      t.references :dealer, index: true
      
      t.string  :title
      t.float  :price
      t.string :phone

      t.text   :params
      t.attachment :image

      t.integer :orders_count

      t.timestamps
    end
  end
end
