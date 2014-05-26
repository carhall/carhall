class ChangeColumnsToTestDrivings < ActiveRecord::Migration
  def change
    change_table :test_drivings do |t|
      t.integer :brand_id
      t.index   :brand_id

      t.string  :series
      t.index   :series

      t.remove :phone
    end

    change_table :dealer_details do |t|
      t.string :test_drive_phone
    end
  end
end
