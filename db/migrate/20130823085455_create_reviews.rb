class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :order, index: true

      t.text    :content
      t.integer :stars
      
      t.timestamps
    end

  end
end
