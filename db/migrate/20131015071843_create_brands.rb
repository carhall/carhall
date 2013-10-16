class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, index: true, unique: true
    end

    Share::Brand::Brands.each do |name| 
      Share::Brand.create(name: name) 
    end

  end
end
