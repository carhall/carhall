class CreateUserDevice < ActiveRecord::Migration
  def change
    create_table :user_device do |t|
      t.references :user
      t.string :sys
      t.string :udid
      t.string :client_token
      
      t.timestamps
    end

    add_index :user_device, :user_id

  end
end
