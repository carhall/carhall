class AccountsAdditionalFields < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      t.remove  :email
      
      # For STI
      t.string  :type
      t.references :detail, index: true
      
      t.string  :username, null: false, default: ""
      t.index   :username

      t.string  :mobile, null: false, default: "", unique: true
      t.index   :mobile
      
      t.text    :description
      t.attachment :avatar

      t.datetime :accepted_at
      t.index    :accepted_at

    end

    Accounts::Admin.create!(mobile: '13012345678', password: 'password', username: '汽车堂')
    Accounts::Admin.first.confirm!

  end
end
