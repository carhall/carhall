class CreateDealerDetails < ActiveRecord::Migration
  def change
    create_table :dealer_details do |t|
      # t.references :source
      t.integer :dealer_type_id
      t.string  :business_scope_ids
      t.string  :company
      t.string  :address
      t.string  :phone
      t.string  :open_during
      t.integer :balance, null: false, default: 0
      t.string  :rqrcode_token
      t.attachment :image

      t.integer :area_id
      t.float :latitude, limit: 32
      t.float :longitude, limit: 32

      t.string  :template_ids
      t.integer :balance_used, null: false, default: 0
      
    end

    # add_index :dealer_details, :source_id
    add_index :dealer_details, :area_id
    add_index :dealer_details, :latitude
    add_index :dealer_details, :longitude
  end
end
