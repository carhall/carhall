class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :source, polymorphic: true
      t.string :content
      
      t.timestamps
    end

    add_index :comments, [:source_type, :source_id]

  end
end
