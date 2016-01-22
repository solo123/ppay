class CreateBulletinBoardSystems < ActiveRecord::Migration
  def change
    create_table :bulletin_board_systems do |t|
      t.datetime :deadtime
      t.string :title
      t.text :content
      t.integer :publisher_id

      t.timestamps null: false
    end
  end
end
