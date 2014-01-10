class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.integer :advert_type_id
      t.index   :advert_type_id

      t.integer :area_id
      t.index   :area_id

      t.integer :brand_id
      t.index   :brand_id

      t.attachment :image
    end
  end
end
