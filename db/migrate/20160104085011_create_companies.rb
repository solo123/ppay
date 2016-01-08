class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.belongs_to :address

      t.integer :company_obj_id
      t.string :company_obj_type

      t.text :name
      t.string :short_name
      t.date :establish_date
      t.string :location
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
