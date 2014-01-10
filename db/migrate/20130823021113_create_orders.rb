class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      # For STI
      t.string  :type

      t.references :user, index: true
      t.references :dealer, index: true
      t.references :detail, index: true
      t.references :source, index: true

      t.string  :title
      t.integer :state_id
      t.index   :state_id
      
      t.float   :cost
      
      t.integer :count, default: 0
      t.integer :used_count, default: 0
      
      t.timestamps
    end

  end
end
