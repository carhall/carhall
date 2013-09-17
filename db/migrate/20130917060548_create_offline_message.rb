class CreateOfflineMessage < ActiveRecord::Migration
  def change
    create_table :offline_message do |t|
      t.references :user
      t.string :content
      
      t.timestamps
    end

    add_index :offline_message, :user_id

  end
end
