class AddWeixinColumnsToDistributorDetails < ActiveRecord::Migration
  def change
    change_table :distributor_details do |t|
      t.string :weixin_app_id
      t.string :weixin_app_secret
      t.text   :weixin_welcome
    end
  end
end
