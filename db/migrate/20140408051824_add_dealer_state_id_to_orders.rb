class AddDealerStateIdToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.integer :dealer_state_id, default: 1
    end
  end
end
