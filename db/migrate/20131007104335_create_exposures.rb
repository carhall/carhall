class CreateExposures < ActiveRecord::Migration
  def change
    create_table :exposures do |t|
      t.references :user
      t.references :at_user
      t.references :provider, index: true
      t.text :content
      t.attachment :image
      
      t.timestamps
    end
  end
end
