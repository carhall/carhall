class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :dealer, index: true
      t.references :location, index: true
      t.integer :area_id, index: true

      t.string   :title
      t.datetime :expire_at, index: true
      t.text     :description
      t.attachment :image
      
      t.timestamps
    end

  end
end
