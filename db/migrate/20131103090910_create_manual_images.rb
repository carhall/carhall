class CreateManualImages < ActiveRecord::Migration
  def change
    create_table :manual_images do |t|
      t.attachment :image
    end
  end
end
