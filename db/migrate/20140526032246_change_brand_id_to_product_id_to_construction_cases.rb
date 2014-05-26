class ChangeBrandIdToProductIdToConstructionCases < ActiveRecord::Migration
  def change
    change_table :construction_cases do |t|
      t.rename :brand_id, :product_id
    end
  end
end
