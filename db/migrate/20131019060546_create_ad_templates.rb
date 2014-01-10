class CreateAdTemplates < ActiveRecord::Migration
  def change
    create_table :ad_templates do |t|
      t.string  :title
      t.float   :price, default: 0.0
      t.integer :product_id
      t.index   :product_id

      t.integer :product_type_id
      t.index   :product_type_id

      t.attachment :avatar
      t.attachment :file

      t.timestamps
    end
  end
end
