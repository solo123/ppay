class CreateImpQfClearings < ActiveRecord::Migration
  def change
    create_table :imp_qf_clearings do |t|
      t.string :yhid
      t.string :qsrq
      t.string :jybs
      t.string :jybj
      t.string :sxf
      t.string :jsje
      t.string :sjqsje
      t.string :qszt
      t.integer :zt
      t.integer :imp_log_id

      t.timestamps null: false
    end
  end
end
