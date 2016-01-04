class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :company_obj_id
      t.string :company_obj_type


      t.text :name
      t.string :short_name

      t.timestamps null: false
    end
  end
end
