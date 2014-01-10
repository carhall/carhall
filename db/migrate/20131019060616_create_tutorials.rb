class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string  :title
      t.integer :product_id
      t.index   :product_id

      t.integer :product_type_id
      t.index   :product_type_id

      t.attachment :avatar
      t.attachment :file

      t.timestamps
    end

    create_join_table :tutorials, :distributor_infos
  end
end
