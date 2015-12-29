class AddJoinDateToClients < ActiveRecord::Migration
  def change
    add_column :clients, :join_date, :string
  end
end
