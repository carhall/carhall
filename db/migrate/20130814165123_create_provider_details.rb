class CreateProviderDetails < ActiveRecord::Migration
  def change
    create_table :provider_details do |t|
      t.string  :company
      t.string  :phone
      # t.integer :balance, null: false, default: 0
      t.string  :rqrcode_token
      # t.attachment :reg_img

    end

  end
end
