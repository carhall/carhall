class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, index: true, unique: true
    end

    Category::Brand::Brands.each do |name| 
      Category::Brand.create(name: name) 
    end

  end
end
