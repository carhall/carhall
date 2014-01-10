class CreateMendings < ActiveRecord::Migration
  def change
    create_table :mendings do |t|
      t.references :dealer, index: true
      t.references :location, index: true
      t.integer :area_id
      t.index   :area_id

      t.text    :discount
      t.string  :brand_ids
      t.text    :description
      
      t.float   :total_cost
      t.index   :total_cost

      t.integer :orders_count, default: 0
      t.integer :reviews_count, default: 0
      t.integer :stars_count, default: 0
      t.index   :orders_count
      t.index   :reviews_count
      t.index   :stars_count

      t.text :total_costs
      
      t.text :orders_counts
      t.text :reviews_counts
      t.text :stars_counts

      t.timestamps
    end

  end
end
