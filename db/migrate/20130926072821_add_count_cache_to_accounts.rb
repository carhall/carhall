class AddCountCacheToAccounts < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      t.integer :posts_count, default: 0, index: true

      t.integer :orders_count, default: 0, index: true
      t.integer :reviews_count, default: 0, index: true
      t.integer :stars_count, default: 0

      t.integer :total_cost, default: 0, index: true

      t.references :location, index: true
    end
  end
end
