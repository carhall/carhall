class CreateOpenDatabaseStructs < ActiveRecord::Migration
  def change
    create_table :open_database_structs do |t|
      t.string :type
      
      t.references :user
      t.references :source, polymorphic: true
      t.text :content
      
      t.timestamps
    end

    change_table :open_database_structs do |t|
      t.index [:type, :id]
      t.index [:source_type, :source_id]
    end
    
  end
end
