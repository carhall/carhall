class CreateClubMasters < ActiveRecord::Migration
  def change
    create_table :club_masters do |t|
      t.references :user
      t.integer :area_id
      t.integer :brand_id
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end

    add_index :club_masters, :user_id
    add_index :club_masters, [:area_id, :brand_id]

  end
end
