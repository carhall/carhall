class CreateProviderDetails < ActiveRecord::Migration
  def change
    create_table :provider_details do |t|
      t.string  :company
      t.string  :phone

      t.string  :template_ids
      
      t.string  :rqrcode_token, unique: true
      t.index   :rqrcode_token
      t.attachment :rqrcode_image

    end

  end
end
