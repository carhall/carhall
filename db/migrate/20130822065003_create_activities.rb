class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :dealer
      t.string   :title
      t.datetime :expire_at
      t.text     :description
      t.attachment :image
      
      t.timestamps
    end

  end
end
