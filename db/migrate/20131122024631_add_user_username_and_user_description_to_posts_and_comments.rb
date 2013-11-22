class AddUserUsernameAndUserDescriptionToPostsAndComments < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :user_username
      t.string :user_description
    end
    Posts::Post.all.each{|p|p.save}

    change_table :comments do |t|
      t.string :user_username
      t.string :at_user_username
    end
    Share::Comment.all.each{|p|p.save}
  end
end
