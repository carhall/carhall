class CreateDealerInfos < ActiveRecord::Migration
  def change
    create_table :dealer_infos do |t|
      t.references :source
      t.integer :dealer_type_id
      t.string  :business_scope_ids
      t.string  :company
      t.string  :address
      t.string  :phone
      t.string  :open
      t.boolean :accepted
      t.integer :balance, null: false, default: 0
      t.attachment :reg_img

      t.float :latitude
      t.float :longitude
      
    end

    add_index :dealer_infos, :source_id
  end
end
