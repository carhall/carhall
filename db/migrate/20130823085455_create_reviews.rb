class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :order

      t.text    :content
      t.integer :stars
      
      t.timestamps
    end

    add_index :reviews, :order_id

  end
end
