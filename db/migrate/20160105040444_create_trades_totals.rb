class CreateTradesTotals < ActiveRecord::Migration
  def change
    create_table :trades_totals do |t|
      t.belongs_to :client
      t.date :trade_date

      t.integer :total_amount, default: 0
      t.integer :total_count, default: 0
      t.integer :weichat_amount, default: 0
      t.integer :weichat_count, default: 0
      t.integer :alipay_amount, default: 0
      t.integer :alipay_count, default: 0
      t.integer :t0_amount, default: 0
      t.integer :t0_count, default: 0
      t.integer :t1_amount, default: 0
      t.integer :t1_count, default: 0

      t.timestamps null: false
    end
  end
end
