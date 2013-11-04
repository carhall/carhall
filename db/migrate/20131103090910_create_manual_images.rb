class CreateManualImages < ActiveRecord::Migration
  def change
    create_table :manual_images do |t|
      t.references :distributor, index: true
      
      t.string :title
      t.attachment :image
    end
  end
end
