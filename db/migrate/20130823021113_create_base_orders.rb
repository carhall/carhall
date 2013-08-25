class CreateBaseOrders < ActiveRecord::Migration
  def change
    create_table :base_orders do |t|
      t.references :user
      t.references :dealer
      t.references :review
      t.references :detail, polymorphic: true
      t.references :source, polymorphic: true
      t.integer  :state_id
      
      t.timestamps
    end

    add_index :base_orders, :user_id
    add_index :base_orders, [:detail_type, :detail_id]
    add_index :base_orders, [:source_type, :source_id]
    add_index :base_orders, :state_id

  end
end
