class CreateClientNotes < ActiveRecord::Migration
  def change
    create_table :client_notes do |t|
      t.belongs_to :client
      t.text :note
      t.string :tip
      t.timestamps null: false
    end
  end
end
