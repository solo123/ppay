class AddMainContactToClients < ActiveRecord::Migration
  def change
    add_column :clients, :main_contact_id, :integer
  end
end
