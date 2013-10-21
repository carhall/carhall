class CreateAccountsClubs < ActiveRecord::Migration
  def change
    create_join_table :accounts, :clubs
  end
end
