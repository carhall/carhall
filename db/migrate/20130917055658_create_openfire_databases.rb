class CreateOpenfireDatabases < ActiveRecord::Migration
  def change
    create_table :user_device do |t|
      t.references :user
      t.string :sys
      t.string :udid
      t.string :client_token
      
      t.integer :created_at, :limit => 8
      t.integer :updated_at, :limit => 8
    end

    create_table :offline_message do |t|
      t.references :user
      t.string :content
      
      t.integer :created_at, :limit => 8
    end

    create_table :apply do |t|
      t.references :from_user
      t.references :to_user
      t.string :content
      
      t.integer :created_at, :limit => 8
    end

    create_table :friend do |t|
      t.references :user
      t.references :friend_user
      
      t.integer :created_at, :limit => 8
    end

    add_index :user_device, :user_id
    add_index :offline_message, :user_id
    add_index :apply, :from_user_id
    add_index :apply, :to_user_id
    add_index :friend, :user_id
    add_index :friend, :friend_user_id
    
  end
end
