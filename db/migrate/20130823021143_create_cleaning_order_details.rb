class CreateCleaningOrderDetails < ActiveRecord::Migration
  def change
    create_table :cleaning_order_details do |t|
      # t.references :source
      t.integer :count, default: 0
      t.integer :used_count, default: 0

    end

    # add_index :cleaning_order_details, :source_id

  end
end
