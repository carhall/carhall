class CreateProgrammes < ActiveRecord::Migration
  def change
    create_table :programmes do |t|
      t.references :provider, index: true
      t.string :title
      t.attachment :avatar
      t.text :description

      t.timestamps
    end
  end
end
