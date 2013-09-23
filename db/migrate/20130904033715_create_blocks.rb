class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :user
      t.references :blacklist

      t.timestamps
    end

    change_table :blocks do |t|
      t.index :user_id
      t.index :blacklist_id
    end

  end
end
