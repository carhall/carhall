class CreateProviderDetails < ActiveRecord::Migration
  def change
    create_table :provider_details do |t|
      t.string  :company
      t.string  :phone
      t.string  :rqrcode_token

    end

  end
end
