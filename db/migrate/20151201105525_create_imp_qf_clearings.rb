class CreateImpQfClearings < ActiveRecord::Migration
  def change
    create_table :imp_qf_clearings do |t|
      t.string :ssid
      t.string :qsrq
      t.string :jybs
      t.string :jybj
      t.string :sxf
      t.string :jsje
      t.string :sjqsje
      t.string :qszt
      t.integer :imp_log_id
      t.integer :zt

      t.timestamps null: false
    end
  end
end
