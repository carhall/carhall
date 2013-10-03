class CreateMendings < ActiveRecord::Migration
  def change
    create_table :mendings do |t|
      t.references :dealer, index: true
      t.references :location, index: true
      t.integer :area_id, index: true

      t.text    :discount
      t.string  :brand_ids
      t.text    :description
      
      t.float   :total_cost, index: true

      t.integer :orders_count, default: 0, index: true
      t.integer :reviews_count, default: 0, index: true
      t.integer :stars_count, default: 0, index: true

      t.text :total_costs
      
      t.text :orders_counts
      t.text :reviews_counts
      t.text :stars_counts

      t.timestamps
    end

  end
end
