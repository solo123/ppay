class AddLxrToClients < ActiveRecord::Migration
  def change
    add_column :clients, :contact_name, :string
  end
end
