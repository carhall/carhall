class ChangeColumnsToSalesCase < ActiveRecord::Migration
  def change
    change_table :sales_cases do |t|
      t.string :title
      t.remove :solution
    end
  end
end
