class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string  :content
      t.integer :stars
      
      t.timestamps
    end

  end
end
