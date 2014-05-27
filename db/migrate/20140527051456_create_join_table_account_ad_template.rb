class CreateJoinTableAccountAdTemplate < ActiveRecord::Migration
  def change
    create_table :accounts_ad_templates do |t|
      t.references :distributor
      t.references :ad_template
    end
  end
end
