class CreateImpOps < ActiveRecord::Migration
  def change
    create_table :imp_ops do |t|
      # 导入邮件
      t.string :start_time
      t.string :end_time
      t.string :imp_count
      t.string :login_status

      t.timestamps null: false
    end
  end
end
