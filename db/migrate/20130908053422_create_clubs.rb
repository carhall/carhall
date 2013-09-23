class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.references :president
      t.string  :mechanic_ids
      t.string  :title
      t.text    :announcement
      t.integer :area_id
      t.integer :brand_id
      t.attachment :avatar

      t.timestamps
    end

    change_table :clubs do |t|
      t.index [:area_id, :brand_id]
    end

  end
end
