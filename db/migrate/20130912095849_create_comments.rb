class CreateComments < ActiveRecord::Migration
   def change
    create_table :comments do |t|
      t.string :type
      t.references :user
      t.references :at_user
      t.references :source, polymorphic: true
      t.text :content
      
      t.timestamps
    end

    change_table :comments do |t|
      t.index [:type, :id]
      t.index [:source_type, :source_id]
    end

  end
end
