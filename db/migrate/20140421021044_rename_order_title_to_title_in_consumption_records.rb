class RenameOrderTitleToTitleInConsumptionRecords < ActiveRecord::Migration
  def change
    change_table :consumption_records do |t|
      t.rename :order_title, :title
      t.change :count, :integer, default: 0
    end
  end
end
