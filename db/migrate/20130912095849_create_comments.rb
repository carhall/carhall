class CreateComments < ActiveRecord::Migration
   def change
    create_table :comments do |t|
      t.references :user
      t.references :at_user
      t.references :post
      t.text :content
      
      t.timestamps
    end

    change_table :comments do |t|
      t.index :post_id
    end

  end
end
