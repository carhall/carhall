class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      # For STI
      t.string  :type

      t.references :user
      t.references :dealer
      t.references :detail
      t.references :source
      t.string  :title
      t.integer :state_id
      
      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :detail_id
    add_index :orders, :source_id
    add_index :orders, :state_id

  end
end
