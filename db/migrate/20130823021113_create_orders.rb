class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      # For STI
      t.string  :type

      t.references :user
      t.references :dealer
      t.references :dealer_detail
      t.references :detail
      t.references :source

      t.string  :title
      t.integer :state_id
      t.float   :cost
      
      t.timestamps
    end

    change_table :orders do |t|
      t.index [:type, :id]
      
      t.index :user_id
      t.index :dealer_id
      t.index :detail_id
      t.index :source_id
      
      t.index :state_id

    end

  end
end
