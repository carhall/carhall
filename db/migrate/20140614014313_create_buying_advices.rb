class CreateBuyingAdvices < ActiveRecord::Migration
  def change
    create_table :buying_advices do |t|
      t.references :user

      t.references :brand3

      t.integer :buying_at_id
      t.integer :buying_pattern_id
      t.boolean :license

      t.string  :title
      t.text    :description

      t.integer :state_id, default: 1
      t.index   :state_id
      
      t.integer :count, default: 1
      t.integer :used_count, default: 1

      t.timestamps
    end
  end
end
