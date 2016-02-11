class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :ref_data_type
      t.integer :ref_data_id
      t.string :page_url
      t.string :host
      t.string :remote_host
      t.string :remote_addr
      t.string :controller
      t.string :action
      t.string :log_title
      t.text :log_detail
      t.integer :parent_id
      t.integer :level, :default => 0
      t.timestamps
    end
  end
end
