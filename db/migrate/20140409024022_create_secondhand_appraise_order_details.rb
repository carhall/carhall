class CreateSecondhandAppraiseOrderDetails < ActiveRecord::Migration
  def change
    create_table :secondhand_appraise_order_details do |t|
      t.integer  :brand_id
      t.index    :brand_id

      t.string   :series
      t.string   :plate_num
      t.text     :description

      t.datetime :purchasing_date
      t.integer  :travelling_miles

      t.timestamps
    end
  end
end
