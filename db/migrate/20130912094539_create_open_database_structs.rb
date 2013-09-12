class CreateOpenDatabaseStructs < ActiveRecord::Migration
  def change
    create_table :open_database_structs do |t|
      t.string :type
      
      t.references :user
      t.references :source, polymorphic: true
      t.string :content
      
      t.timestamps
    end

    add_index :open_database_structs, [:source_type, :source_id]
    add_index :open_database_structs, [:type, :id]

  end
end
