class AccountsAdditionalFields < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      t.remove  :email
      
      # For STI
      t.string  :type
      t.references :detail, index: true
      
      t.string  :username, null: false, default: "", index: true
      t.string  :mobile, null: false, default: "", index: true, unique: true
      t.text    :description
      t.attachment :avatar

      t.datetime :accepted_at, index: true

    end

    Accounts::Admin.create!(mobile: '13012345678', password: 'password', username: '汽车堂')

  end
end
