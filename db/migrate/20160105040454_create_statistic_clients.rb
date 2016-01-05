class CreateStatisticClients < ActiveRecord::Migration
  def change
    create_table :statistic_clients do |t|

      t.timestamps null: false
    end
  end
end
