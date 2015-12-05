class CreateImpQfTrades < ActiveRecord::Migration
  def change
    create_table :imp_qf_trades do |t|
      t.string :ssid
      t.string :zzh
      t.string :jyrq
      t.string :jylx
      t.string :jyjg
      t.string :jye
      t.string :zdcm
      t.integer :zt

      t.timestamps null: false
    end
  end
end
