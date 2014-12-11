class CreateCheyouhuiRegions < ActiveRecord::Migration
  def change
    create_table :cheyouhui_regions do |t|
      t.integer :user_id
      t.string :name
      t.string :url
      t.string :token
      t.integer :status
      t.timestamps
    end
  end
end
