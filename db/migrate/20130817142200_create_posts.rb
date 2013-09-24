class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :club
      t.text :content

      t.integer :comments_count, default: 0 

      t.attachment :image
      
      t.timestamps
    end
    
    change_table :posts do |t|
      t.index :user_id
      t.index :club_id

      t.index :comments_count

    end

  end
end
