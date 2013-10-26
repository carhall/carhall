class AddTemplateIdsToProviderDetails < ActiveRecord::Migration
  def change
    change_table :provider_details do |t|
      t.string  :template_ids
    end
  end
end
