class AddUsedCountToBulkPurchasing2Orders < ActiveRecord::Migration
  def change
    change_table :bulk_purchasing2_orders do |t|
      t.integer :used_count, default: 0
      t.change :state_id, :integer, default: 1
    end
  end
end
