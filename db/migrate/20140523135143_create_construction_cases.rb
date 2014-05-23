class CreateConstructionCases < ActiveRecord::Migration
  def change
    create_table :construction_cases do |t|
      t.references :distributor, index: true
      t.references :dealer, index: true

      t.string :title
      t.integer :brand_id
      t.attachment :image
    end
  end
end
