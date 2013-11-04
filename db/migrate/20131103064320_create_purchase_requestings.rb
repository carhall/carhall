class CreatePurchaseRequestings < ActiveRecord::Migration
  def change
    create_table :purchase_requestings do |t|
      t.references :dealer

      t.string   :title
      t.datetime :expire_at
      t.integer  :purchase_requesting_type_id
      t.integer  :main_area_id
      t.string   :price_range
      t.text     :description

      t.attachment :image
    end
  end
end
