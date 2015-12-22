class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :contact

      t.integer :province_code
      t.integer :city_code
      t.string :street
      t.string :post_code
      t.integer :status

      t.timestamps null: false
    end
  end
end
# 关联类名
# 关联对象ID	integer
