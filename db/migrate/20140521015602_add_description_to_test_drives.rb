class AddDescriptionToTestDrivings < ActiveRecord::Migration
  def change
    change_table :test_drivings do |t|
      t.text :description
    end
  end
end
