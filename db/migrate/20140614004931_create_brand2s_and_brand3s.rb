class CreateBrand2sAndBrand3s < ActiveRecord::Migration
  def change
    create_table :brand2s do |t|
      t.references :brand

      t.string :name, unique: true
      t.index  :name

      t.attachment :image
    end

    create_table :brand3s do |t|
      t.references :brand
      t.references :brand2

      t.string :name, unique: true
      t.index  :name
      
      t.attachment :image
    end
  end
end
