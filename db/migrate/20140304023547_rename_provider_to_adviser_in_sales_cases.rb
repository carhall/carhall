class RenameProviderToAdviserInSalesCases < ActiveRecord::Migration
  def change
    change_table :sales_cases do |t|
      t.rename :provider, :adviser
      
      t.timestamps
    end
  end
end
