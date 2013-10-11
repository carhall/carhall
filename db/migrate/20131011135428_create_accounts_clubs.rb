class CreateAccountsClubs < ActiveRecord::Migration
  def change
    create_table :accounts_clubs do |t|
      t.references :user
      t.references :club
    end
  end
end
