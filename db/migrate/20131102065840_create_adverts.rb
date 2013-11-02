class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.integer :advert_type_id, index: true
      t.integer :area_id, index: true
      t.integer :brand_id, index: true

      t.attachment :image
    end
  end
end
