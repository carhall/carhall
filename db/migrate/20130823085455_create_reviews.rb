class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :order

      t.text    :content
      t.integer :stars
      
      t.timestamps
    end

    change_table :reviews do |t|
      t.index :order_id
    end
    
  end
end
