class TradeSums < ActiveRecord::Migration
  def change
    create_table :trade_sums do |t|
      t.references :sum_obj, polymorphic: true, index: true
      t.string :trade_date, index: true
      t.string :sum_type, index: true
      t.string :trade_type, index: true
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.integer :count, default: 0
      t.timestamps null: false
    end
  end
end
