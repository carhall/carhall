class CreateDealerDetails < ActiveRecord::Migration
  def change
    create_table :dealer_details do |t|
      t.references :location
      t.references :rating_cache
      t.integer :area_id

      t.integer :dealer_type_id
      t.string  :business_scope_ids
      t.string  :company
      t.string  :address
      t.string  :phone
      t.string  :open_during
      t.integer :balance, null: false, default: 0
      t.string  :rqrcode_token
      t.attachment :image

      t.string  :template_ids
      t.integer :balance_used, null: false, default: 0

    end

    change_table :dealer_details do |t|
      t.index :location_id
      t.index :rating_cache_id
      t.index :area_id

      t.index :dealer_type_id
      t.index :rqrcode_token, unique: true

    end

  end
end
