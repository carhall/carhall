class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :dealer
      t.references :location
      t.integer :area_id

      t.string   :title
      t.datetime :expire_at
      t.text     :description
      t.attachment :image
      
      t.timestamps
    end

    change_table :activities do |t|
      t.index :dealer_id
      t.index :location_id
      t.index :area_id

    end

  end
end
