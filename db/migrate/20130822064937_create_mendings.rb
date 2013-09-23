class CreateMendings < ActiveRecord::Migration
  def change
    create_table :mendings do |t|
      t.references :dealer
      t.references :location
      t.references :rating_cache
      t.integer :area_id

      t.text    :discount
      t.string  :brand_ids, limit: 1024
      t.text    :description
      t.integer :orders_count, default: 0
      
      t.timestamps
    end

    change_table :mendings do |t|
      t.index :dealer_id
      t.index :location_id
      t.index :rating_cache_id
      t.index :area_id

      t.index :orders_count

    end

  end
end
