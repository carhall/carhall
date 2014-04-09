class CreateVehicleInsuranceOrderDetails < ActiveRecord::Migration
  def change
    create_table :vehicle_insurance_order_details do |t|
      t.integer :brand_id
      t.index   :brand_id

      t.string  :series
      t.string  :plate_num
      
      t.text    :description
      
      t.integer :insurance_type_id
      t.index   :insurance_type_id
    end
  end
end
