class ProfitLadders < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :contract_type
      t.string :contract_title
      t.string :profit_mode
      t.string :trade_type
      t.date :valid_date_from
      t.date :valid_date_to
      t.integer :status, default: 0
      t.timestamps null: false
    end
    create_table :profit_ladders do |t|
      t.belongs_to :contract
      t.decimal :amount_start, precision: 12, scale: 2, default: 0
      t.decimal :amount_percent, precision: 12, scale: 2, default: 0
      t.timestamps null: false
    end
    create_table :agents_contracts, id: false do |t|
      t.belongs_to :agent, index: true
      t.belongs_to :contract, index: true
    end
    create_table :salesmen_contracts, id: false do |t|
      t.belongs_to :saleman, index: true
      t.belongs_to :contract, index: true
    end
  end
end
