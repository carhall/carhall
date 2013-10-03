class CreateOpenfireDatabases < ActiveRecord::Migration
  def change
    create_table :user_device do |t|
      t.references :user, index: true
      t.string :sys
      t.string :udid
      t.string :client_token
      
      t.integer :created_at, :limit => 8
      t.integer :updated_at, :limit => 8
    end

    create_table :offline_message do |t|
      t.references :user, index: true
      t.text :content
      
      t.integer :created_at, :limit => 8
    end

    create_table :apply do |t|
      t.references :from_user, index: true
      t.references :to_user, index: true
      t.text :content
      
      t.integer :created_at, :limit => 8
    end

    create_table :friend do |t|
      t.references :user, index: true
      t.references :friend, index: true
      
      t.integer :created_at, :limit => 8
      t.integer :updated_at, :limit => 8
    end
  end
end
