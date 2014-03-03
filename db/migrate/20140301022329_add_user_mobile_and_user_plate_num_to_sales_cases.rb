class AddUserMobileAndUserPlateNumToSalesCases < ActiveRecord::Migration
  def change
    change_table :sales_cases do |t|
      t.string :user_mobile
      t.index  :user_mobile
      t.string :user_plate_num
      t.index  :user_plate_num
    end

    Statistic::SalesCase.all.each do |sales_case|
      sales_case.save
    end
  end
end
