class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :file
      t.integer :type_id
      t.index   :type_id
    end
  end
end
