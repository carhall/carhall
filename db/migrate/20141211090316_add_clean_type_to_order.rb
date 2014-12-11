class AddCleanTypeToOrder < ActiveRecord::Migration
  def change
  	change_table(:orders) do |t|
  	  t.integer :cleaning_type_id
      t.index   :cleaning_type_id
  	end
  end
end
