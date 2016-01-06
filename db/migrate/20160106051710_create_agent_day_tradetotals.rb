class CreateAgentDayTradetotals < ActiveRecord::Migration
  def change
    create_table :agent_day_tradetotals do |t|
      t.belongs_to :agent
      t.date :trade_date

      t.decimal :total_amount, precision: 12, scale: 2, default: 0
      t.integer :total_count, default: 0
      t.decimal :weichat_amount, precision: 12, scale: 2, default: 0
      t.integer :weichat_count, default: 0
      t.decimal :alipay_amount, precision: 12, scale: 2, default: 0
      t.integer :alipay_count, default: 0
      t.decimal :t0_amount, precision: 12, scale: 2, default: 0
      t.integer :t0_count, default: 0
      t.decimal :t1_amount, precision: 12, scale: 2, default: 0
      t.integer :t1_count, default: 0

      # 清算数据
      t.decimal :expected_amount, precision: 12, scale: 2, default: 0
      t.decimal :actual_amount, precision: 12, scale: 2, default: 0
      t.decimal :diff_amount, precision: 12, scale: 2, default: 0
      t.decimal :diff_total_amount, precision: 12, scale: 2, default: 0

      t.timestamps null: false
    end
  end
end
