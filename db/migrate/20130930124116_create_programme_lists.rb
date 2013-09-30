class CreateProgrammeLists < ActiveRecord::Migration
  def change
    create_table :programme_lists do |t|
      t.references :provider, index: true
      t.text :list

      t.timestamps
    end
  end
end
