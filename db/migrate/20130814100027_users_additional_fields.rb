class UsersAdditionalFields < ActiveRecord::Migration
  def change
    change_table(:base_users) do |t|
      t.string  :username, null: false, default: ""
      # t.string  :nickname, null: false, default: ""
      t.string  :mobile, null: false, default: "", unique: true
      t.text    :description
      t.attachment :avatar

      t.datetime :accepted_at

      t.references :detail, polymorphic: true
    end

    add_index :base_users, :username
    add_index :base_users, :mobile

    add_index :base_users, [:detail_type, :detail_id]

    BaseUser.create!(mobile: '15901013540', password: 'password', username: '汽车堂')
  end
end
