class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.references :provider, index: true
      t.string :name
      t.attachment :avatar
      t.text :description

      t.timestamps
    end
  end
end
