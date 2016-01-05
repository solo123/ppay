class CreateStatisticTrades < ActiveRecord::Migration
  def change
    create_table :statistic_trades do |t|

      t.timestamps null: false
    end
  end
end
