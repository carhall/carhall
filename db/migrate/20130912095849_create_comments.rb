class CreateComments < ActiveRecord::Migration
   def change
    create_table :comments do |t|
      t.references :user
      t.references :post
      t.text :content
      
      t.timestamps
    end

    add_index :comments, :post_id

  end
end
