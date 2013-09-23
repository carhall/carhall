class CreateCleaningOrderDetails < ActiveRecord::Migration
  def change
    create_table :cleaning_order_details do |t|
      t.integer :count, default: 0
      t.integer :used_count, default: 0

    end

  end
end
