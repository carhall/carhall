class CreatePostBlocks < ActiveRecord::Migration
  def change
    create_table :post_blocks do |t|
      t.references :user
      t.references :blacklist

      t.timestamps
    end

    add_index :post_blocks, :user_id
    add_index :post_blocks, :blacklist_id

  end
end
