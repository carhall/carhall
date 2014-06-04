class AddTimestampsToConstructionCases < ActiveRecord::Migration
  def change
    change_table :construction_cases do |t|
      t.timestamps
    end

    Tips::ConstructionCase.update_all(created_at: Time.now, updated_at: Time.now)
  end
end
