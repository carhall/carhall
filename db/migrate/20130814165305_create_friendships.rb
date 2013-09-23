class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user
      t.references :friend

      t.timestamps
    end

    change_table :friendships do |t|
      t.index :user_id
      t.index :friend_id
    end

  end
end
