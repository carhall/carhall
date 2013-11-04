class CreateBulkPurchasing2Orders < ActiveRecord::Migration
  def change
    create_table :bulk_purchasing2_orders do |t|
      t.references :dealer, index: true
      t.references :distributor, index: true
      t.references :source, index: true

      t.string  :title
      t.integer :state_id, index: true
      t.float   :cost
      
      t.integer :count, default: 0
      
      t.timestamps
    end
  end
end
