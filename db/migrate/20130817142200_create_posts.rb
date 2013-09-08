class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :club
      t.string :content
      t.integer :view_count, default: 0 
      t.integer :comments_count, default: 0 
      t.float :weight, default: 0 

      t.attachment :image
      
      t.timestamps
    end
    
    add_index :posts, :user_id
    add_index :posts, :club_id
    add_index :posts, :view_count
    add_index :posts, :comments_count

  end
end
