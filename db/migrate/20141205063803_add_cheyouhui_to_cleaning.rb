class AddCheyouhuiToCleaning < ActiveRecord::Migration
  def change
  	change_table(:cleanings) do |t|

       t.column :is_cheyouhui,:boolean,default: false
      
     end
  end
end
