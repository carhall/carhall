class CreateConsumptionRecords < ActiveRecord::Migration
  def change
    create_table :consumption_records do |t|
      t.references :user, index: true
      t.references :dealer, index: true
      t.references :order, index: true, polymorphic: true
      t.string :order_title
      t.string :count

      t.timestamps
    end
  end
end
