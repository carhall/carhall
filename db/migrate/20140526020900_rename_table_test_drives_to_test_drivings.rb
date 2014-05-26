class RenameTableTestDrivesToTestDrivings < ActiveRecord::Migration
  def change
    Tips::Order.where(type: 'Tips::TestDriveOrder').update_all(type: 'Tips::TestDrivingOrder')
    rename_table :test_drives, :test_drivings
  end
end
