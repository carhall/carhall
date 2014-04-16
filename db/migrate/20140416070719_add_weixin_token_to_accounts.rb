class AddWeixinTokenToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :weixin_token
      t.index :weixin_token
    end
  end
end
