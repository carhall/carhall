class CreateApply < ActiveRecord::Migration
  def change
    create_table :apply do |t|
      t.references :from_user
      t.references :to_user
      t.string :content
      
      t.timestamps
    end

  end
end
