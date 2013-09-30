class AddCountCacheToAccounts < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      t.integer :posts_count, default: 0

      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0
      t.integer :stars_count, default: 0

      t.integer :total_cost, default: 0

      t.references :location

      t.index :posts_count

      t.index :orders_count
      t.index :reviews_count
      t.index :stars_count
      
      t.index :total_cost

      t.index :location_id

    end
  end
end
