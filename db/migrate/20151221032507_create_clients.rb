class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :salesman

      t.string :shop_name
      t.string :shop_tel
      t.integer :category_id
      # t.integer :contact_id
      # t.integer :salesman_id
      t.decimal :rate, precision: 12, scale: 6
      t.decimal :bank_card_limit_each, precision: 12, scale: 2
      t.decimal :bank_card_limit_month, precision: 12, scale: 2
      t.decimal :credit_card_limit_each, precision: 12, scale: 2
      t.decimal :credit_card_limit_month, precision: 12, scale: 2

      t.timestamps null: false
    end
  end
end
