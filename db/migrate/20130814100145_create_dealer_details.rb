class CreateDealerDetails < ActiveRecord::Migration
  def change
    create_table :dealer_details do |t|
      t.integer :area_id, index: true
      
      t.integer :dealer_type_id, index: true
      t.string  :business_scope_ids
      t.string  :company
      t.string  :address
      t.string  :phone
      t.string  :open_during
      t.integer :balance, null: false, default: 0
      t.string  :rqrcode_token, index: true, unique: true
      t.attachment :image

      t.string  :template_ids
      t.integer :balance_used, null: false, default: 0

    end

  end
end
