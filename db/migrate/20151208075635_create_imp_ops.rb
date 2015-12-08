class CreateImpOps < ActiveRecord::Migration
  def change
    create_table :imp_ops do |t|
      # 登录邮件
      t.string :login_status

      t.timestamps null: false
    end
  end
end
