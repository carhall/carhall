class CreateRatingCaches < ActiveRecord::Migration
  def change
    create_table :rating_caches do |t|
      t.float   :stars_average, :null => false  
      t.integer :reviews_count, :null => false
      
      t.timestamps
    end

    change_table :rating_caches do |t|
      t.index :stars_average
      t.index :reviews_count
    end
  end
end
