class CreateDistributorDetails < ActiveRecord::Migration
  def change
    create_table :distributor_details do |t|
      t.integer :distributor_type_id
      t.index   :distributor_type_id
      
      t.string  :business_scope_ids

      t.string  :product_ids
      t.string  :brand_ids
      t.string  :company
      t.string  :address
      t.string  :phone
      t.string  :rqrcode_token

      t.attachment :image
      t.attachment :rqrcode_image
    end
  end
end
