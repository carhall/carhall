class AddWeixinWelcomeToDealerDetails < ActiveRecord::Migration
  def change
    change_table :dealer_details do |t|
      t.text :weixin_welcome
    end
  end
end
