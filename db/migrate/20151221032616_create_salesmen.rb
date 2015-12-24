class CreateSalesmen < ActiveRecord::Migration
  def change
    create_table :salesmen do |t|
      t.belongs_to :agent
      t.belongs_to :salesman
      t.string :name

      t.timestamps null: false
    end
  end
end
