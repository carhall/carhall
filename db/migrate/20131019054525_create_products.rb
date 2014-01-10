class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, unique: true
      t.index  :name
    end

    Category::Product::Products.each do |name| 
      Category::Product.create(name: name) 
    end
    
  end
end
