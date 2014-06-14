class CreateBuyingAdviceOrders < ActiveRecord::Migration
  def change
    create_table :buying_advice_orders do |t|
      t.references :user
      t.references :dealer
      t.references :buying_advice

      t.string :title
      t.float  :price
      t.text   :description
      t.string :adviser
      
      t.timestamps
    end
  end
end
