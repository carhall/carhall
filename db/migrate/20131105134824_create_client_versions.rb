class CreateClientVersions < ActiveRecord::Migration
  def change
    create_table :client_versions do |t|
      t.integer :client_type_id
      t.integer :version
      
      t.attachment :file

    end
  end
end
