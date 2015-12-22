class CreatePosMachines < ActiveRecord::Migration
  def change
    create_table :pos_machines do |t|
      t.string :serial_number
      t.integer :client_id
      t.string :brand
      t.string :model

      t.timestamps null: false
    end
  end
end
