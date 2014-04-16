class AddWeixinColumnsToDealerDetails < ActiveRecord::Migration
  def change
    change_table :dealer_details do |t|
      t.string :weixin_app_id
      t.string :weixin_app_secret
    end
  end
end
