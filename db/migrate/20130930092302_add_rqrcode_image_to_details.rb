class AddRqrcodeImageToDetails < ActiveRecord::Migration
  def change
    change_table :dealer_details do |t|
      t.attachment :rqrcode_image
    end

    change_table :provider_details do |t|
      t.attachment :rqrcode_image
    end
  end
end
