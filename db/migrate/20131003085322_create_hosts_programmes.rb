class CreateHostsProgrammes < ActiveRecord::Migration
  def change
    create_table :hosts_programmes, id: false do |t|
      t.references :host, index: true
      t.references :programme, index: true
    end
  end
end
