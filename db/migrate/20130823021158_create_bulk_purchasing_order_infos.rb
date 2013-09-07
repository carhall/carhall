class CreateBulkPurchasingOrderInfos < ActiveRecord::Migration
    def change
    create_table :bulk_purchasing_order_infos do |t|
      t.references :source
      t.float    :price
      t.integer  :count

    end

    add_index :bulk_purchasing_order_infos, :source_id

  end
end
