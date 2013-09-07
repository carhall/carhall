class CreateCleaningOrderInfos < ActiveRecord::Migration
  def change
    create_table :cleaning_order_infos do |t|
      t.references :source
      t.float   :price
      t.integer :count
      t.integer :used_count

    end

    add_index :cleaning_order_infos, :source_id

  end
end
