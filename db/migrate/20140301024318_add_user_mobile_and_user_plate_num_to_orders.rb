class AddUserMobileAndUserPlateNumToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :user_mobile
      t.index  :user_mobile
      t.string :user_plate_num
      t.index  :user_plate_num
    end

    Tips::Order.all.each do |order|
      order.save
    end
  end
end
