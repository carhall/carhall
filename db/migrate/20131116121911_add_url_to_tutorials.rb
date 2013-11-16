class AddUrlToTutorials < ActiveRecord::Migration
  def change
    change_table :tutorials do |t|
      t.text :url
    end
  end
end
