class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, index: true, unique: true
    end

    Category::Product::Products.each do |name| 
      Category::Product.create(name: name) 
    end
    
  end
end
