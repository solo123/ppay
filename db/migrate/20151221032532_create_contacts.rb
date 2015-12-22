class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :salesman
      t.belongs_to :client

      t.string :name
      t.string :tel
      t.string :qq
      t.string :wechart
      t.string :cid
      t.datetime :cid_verified_date
      t.string :roles
      t.integer :status
      t.timestamps null: false
    end
  end
end
