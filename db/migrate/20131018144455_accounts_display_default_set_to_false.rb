class AccountsDisplayDefaultSetToFalse < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.change :display, :boolean, default: false, index: true
    end
  end
end
