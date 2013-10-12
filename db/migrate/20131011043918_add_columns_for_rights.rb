class AddColumnsForRights < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.integer :position, default: 0
      t.boolean :display, default: true
      t.integer :rank_id, default: 1
    end

    change_table :mendings do |t|
      t.integer :position, default: 0
      t.boolean :display, default: true
    end
    change_table :cleanings do |t|
      t.integer :position, default: 0
      t.boolean :display, default: true
    end
    change_table :activities do |t|
      t.integer :position, default: 0
      t.boolean :display, default: true
    end
    change_table :bulk_purchasings do |t|
      t.integer :position, default: 0
      t.boolean :display, default: true
    end

    change_table :orders do |t|
      t.change :state_id, :integer, default: 1
    end

  end
end
