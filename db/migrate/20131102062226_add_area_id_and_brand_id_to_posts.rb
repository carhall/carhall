class AddAreaIdAndBrandIdToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.integer :area_id, index: true
      t.integer :brand_id, index: true
    end

    Posts::Post.all do |p|
      c = Club.find p.club_id
      p.area_id = c.area_id
      p.brand_id = c.brand_id
      p.save
    end

    change_table :posts do |t|
      t.remove :club_id
    end
  end
end
