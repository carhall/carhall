class CreateMendings < ActiveRecord::Migration
  def change
    create_table :mendings do |t|
      t.references :dealer
      t.text    :discount
      t.text    :brand_ids
      t.text    :description
      t.integer :mending_orders_count
      
      t.timestamps
    end

  end
end
