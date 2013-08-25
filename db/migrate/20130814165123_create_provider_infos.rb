class CreateProviderInfos < ActiveRecord::Migration
  def change
    create_table :provider_infos do |t|
      t.references :source
      t.string :company
      t.string :phone
      t.attachment :reg_img

    end

    add_index :provider_infos, :source_id

    Provider.create!(mobile: '12345678901', password: 'password', password_confirmation: 'password')
  end
end
