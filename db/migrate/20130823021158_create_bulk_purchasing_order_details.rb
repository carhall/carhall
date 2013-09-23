class CreateBulkPurchasingOrderDetails < ActiveRecord::Migration
    def change
    create_table :bulk_purchasing_order_details do |t|
      t.integer  :count, default: 0

    end

  end
end
