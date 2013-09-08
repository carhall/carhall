class CreateCleaningOrderDetails < ActiveRecord::Migration
  def change
    create_table :cleaning_order_details do |t|
      # t.references :source
      t.float   :price
      t.integer :count
      t.integer :used_count

    end

    # add_index :cleaning_order_details, :source_id

  end
end
