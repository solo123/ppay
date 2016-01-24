class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.datetime :publish_date
      t.datetime :close_date
      t.string :title
      t.text :content
      t.integer :publisher_id

      t.timestamps null: false
    end
  end
end
