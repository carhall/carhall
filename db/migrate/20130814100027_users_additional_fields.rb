class UsersAdditionalFields < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
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

    add_index :users, :username
    add_index :users, :mobile

    add_index :users, :detail_id

    # User.create!(mobile: '15901013540', password: 'password', username: '汽车堂')
  end
end
