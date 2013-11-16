class CreateDistributorInfos < ActiveRecord::Migration
  def change
    create_table :distributor_infos do |t|
      t.references :tutorial
      
      t.string  :company
      t.string  :address
      t.string  :phone
    end
  end
end
