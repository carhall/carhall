class AddFriendsCountToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.integer :friends_count
    end
  end
end
