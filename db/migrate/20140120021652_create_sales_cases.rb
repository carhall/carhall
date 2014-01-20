class CreateSalesCases < ActiveRecord::Migration
  def change
    create_table :sales_cases do |t|
      t.references :user, index: true
      t.references :dealer, index: true
      t.text :description
      t.text :solution
      t.string :provider
    end
  end
end
