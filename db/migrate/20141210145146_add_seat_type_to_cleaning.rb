class AddSeatTypeToCleaning < ActiveRecord::Migration
  def change
  	change_table(:cleanings) do |t|
  	  t.integer :seat_type_id
      t.index   :seat_type_id
  	end
  end
end
