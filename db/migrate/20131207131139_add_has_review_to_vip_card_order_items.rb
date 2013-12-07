class AddHasReviewToVipCardOrderItems < ActiveRecord::Migration
  def change
    change_table :vip_card_order_items do |t|
      t.boolean :has_review, default: false
    end
  end
end
