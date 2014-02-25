class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true

      t.integer :area_id
      t.integer :brand_id
      t.index   [:area_id, :brand_id]

      t.text :content

      t.integer :comments_count, default: 0
      t.index   :comments_count

      t.attachment :image
      
      t.timestamps
    end

  end
end
