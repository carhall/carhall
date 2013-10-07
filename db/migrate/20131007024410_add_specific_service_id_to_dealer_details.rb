class AddSpecificServiceIdToDealerDetails < ActiveRecord::Migration
  def change
    add_column :dealer_details, :specific_service_id, :integer
  end
end
