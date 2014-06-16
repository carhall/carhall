class CreateSellingBrands < ActiveRecord::Migration
  def change
    create_table :selling_brands do |t|
      t.references :dealer
      t.references :brand
    end
  end
end
