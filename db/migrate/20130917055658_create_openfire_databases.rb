class CreateOpenfireDatabases < ActiveRecord::Migration
  def change
    create_table :user_device do |t|
      t.references :user
      t.string :sys
      t.string :udid
      t.string :client_token
      
      t.integer :created_at
      t.integer :updated_at
    end

    create_table :offline_message do |t|
      t.references :user
      t.string :content
      
      t.integer :created_at
    end

    create_table :apply do |t|
      t.references :from_user
      t.references :to_user
      t.string :content
      
      t.integer :created_at
    end

    add_index :user_device, :user_id
    add_index :offline_message, :user_id
    
  end
end
