class AddColumnsToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.integer :sex_id

      t.integer :area_id
      t.integer :brand_id
    end

    change_table :accounts do |t|
      t.index [:area_id, :brand_id]
    end

    change_table :dealer_details do |t|
      t.remove :area_id
    end

    change_table :user_details do |t|
      t.remove :sex_id
      t.remove :area_id
      t.remove :brand_id
    end

  end
end
