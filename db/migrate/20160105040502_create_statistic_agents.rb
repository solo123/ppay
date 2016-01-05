class CreateStatisticAgents < ActiveRecord::Migration
  def change
    create_table :statistic_agents do |t|

      t.timestamps null: false
    end
  end
end
