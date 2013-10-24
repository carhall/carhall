class CreateBlacklistForOpenfire < ActiveRecord::Migration
  def change
    create_table :blacklist do |t|
      t.references :user, index: true
      t.references :blacklist, index: true
      
      t.integer :created_at, :limit => 8
      t.integer :updated_at, :limit => 8
    end
  end
end
