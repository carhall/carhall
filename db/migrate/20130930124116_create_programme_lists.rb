class CreateProgrammeLists < ActiveRecord::Migration
  def change
    create_table :programme_lists do |t|
      t.references :provider, index: true
      t.string :airdate
      t.string :title
      t.text   :description
      t.string :day

      t.timestamps
    end
  end
end
