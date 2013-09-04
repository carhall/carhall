class CreateMechanics < ActiveRecord::Migration
  def change
    create_table :mechanics do |t|
      t.references :user
      t.integer :area_id
      t.integer :brand_id
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end

    add_index :mechanics, :user_id
    add_index :mechanics, [:area_id, :brand_id]

  end
end
