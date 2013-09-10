class CreateMendings < ActiveRecord::Migration
  def change
    create_table :mendings do |t|
      t.references :dealer
      t.text    :discount
      t.text    :brand_ids
      t.text    :description
      t.integer :orders_count, default: 0
      
      t.timestamps
    end

   add_index :mendings, :orders_count

  end
end
