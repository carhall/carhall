class AccountsAdditionalFields < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      # For STI
      t.string  :type

      t.string  :username, null: false, default: ""
      # t.string  :nickname, null: false, default: ""
      t.string  :mobile, null: false, default: "", unique: true
      t.text    :description
      t.attachment :avatar

      t.datetime :accepted_at

      t.references :detail
    end

    add_index :accounts, :username
    add_index :accounts, :mobile

    add_index :accounts, :detail_id

    add_index :accounts, [:type, :id]

    # User.create!(mobile: '15901013540', password: 'password', username: '汽车堂')
  end
end
