class AddPhonesToDealerDetails < ActiveRecord::Migration
  def change
    change_table :dealer_details do |t|
      t.string :rescue_phone
      t.string :insurance_phone
      t.string :secondhand_appraise_phone
      t.string :postsale_phone
    end
  end
end
