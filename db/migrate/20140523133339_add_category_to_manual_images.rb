class AddCategoryToManualImages < ActiveRecord::Migration
  def change
    change_table :manual_images do |t|
      t.string :category
    end
  end
end
