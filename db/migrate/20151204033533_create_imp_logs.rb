class CreateImpLogs < ActiveRecord::Migration
  def change
    create_table :imp_logs do |t|
      t.string :email_uid
      t.string :email_title
      t.string :email_time
      t.string :process_status # 处理状态 0:未处理，1:跳过, 7:失败, 8:成功	integer
      t.text :detail
      t.string :datetime_flag

      t.timestamps null: false
    end

  end
end
