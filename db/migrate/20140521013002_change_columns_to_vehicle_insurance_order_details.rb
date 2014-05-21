class ChangeColumnsToVehicleInsuranceOrderDetails < ActiveRecord::Migration
  def change
    change_table :vehicle_insurance_order_details do |t|
      t.remove :insurance_type_id

      t.string :insurance_type_ids
    end
  end
end
