class AddDescriptionToTestDrives < ActiveRecord::Migration
  def change
    change_table :test_drives do |t|
      t.text :description
    end
  end
end
