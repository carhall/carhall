class AddNotifiedToMendingOrderDetails < ActiveRecord::Migration
  def change
    change_table :mending_order_details do |t|
      t.boolean :notified, default: false
    end

    change_table :programme_lists do |t|
      t.change :day, :string
    end
  end
end
