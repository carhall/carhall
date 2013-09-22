class CreateMendings < ActiveRecord::Migration
  def change
    create_table :mendings do |t|
      t.references :dealer
      t.references :dealer_detail
      t.text    :discount
      t.string  :brand_ids
      t.text    :description
      t.integer :orders_count, default: 0
      
      t.timestamps
    end

   add_index :mendings, :orders_count

  end
end
