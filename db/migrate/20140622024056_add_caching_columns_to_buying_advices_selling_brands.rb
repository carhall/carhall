class AddCachingColumnsToBuyingAdvicesSellingBrands < ActiveRecord::Migration
  def change
    change_table :buying_advices do |t|
      t.references :main_area
      t.references :brand
      t.references :brand2
    end

    change_table :selling_brands do |t|
      t.references :main_area
    end

  end
end
