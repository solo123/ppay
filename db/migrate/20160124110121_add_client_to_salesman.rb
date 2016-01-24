class AddClientToSalesman < ActiveRecord::Migration
  def change
    add_column :salesmen, :client_id, :integer
  end
end
