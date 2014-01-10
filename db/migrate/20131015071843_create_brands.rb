class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, unique: true
      t.index  :name
    end

    Category::Brand::Brands.each do |name| 
      Category::Brand.create(name: name) 
    end

  end
end
