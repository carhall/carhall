class CreateSalesCases < ActiveRecord::Migration
  def change
    create_table :sales_cases do |t|
      t.references :user, index: true
      t.references :dealer, index: true
      t.text :description
      t.text :solution
      t.string :adviser

      t.string :user_mobile
      t.index  :user_mobile

      t.string :user_plate_num
      t.index  :user_plate_num
      
      t.integer :state_id, default: 1
      t.index   :state_id
      
      t.timestamps
    end
  end
end
