class AddFieldsToAccouts < ActiveRecord::Migration
  def change
  	change_table(:accounts) do |t|
       t.column :weixin_open_id, :string
       t.column :region_id,:integer
       t.column :is_activate,:boolean,default: true
       t.column :weixin_image,:string
     end
  end
end
