class SetOrdersCostDefaultValue < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.change :cost, :float, default: 0.0
    end

    change_table :reviews do |t|
      t.change :stars, :integer, default: 0
    end
  end
end
