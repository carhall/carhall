class AccountsAdditionalFields < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      # For STI
      t.string  :type
      t.references :detail
      
      t.string  :username, null: false, default: ""
      t.string  :mobile, null: false, default: "", unique: true
      t.text    :description
      t.attachment :avatar

      t.datetime :accepted_at

    end

    change_table :accounts do |t|
      t.index [:type, :id]
      t.index :detail_id

      t.index :username
      t.index :mobile, unique: true

      t.index :accepted_at

    end

    Accounts::Admin.create!(mobile: '15901013540', password: 'password', username: '汽车堂')

  end
end
