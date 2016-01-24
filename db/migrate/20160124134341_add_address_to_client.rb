class AddAddressToClient < ActiveRecord::Migration
  def change
    add_column :clients, :address_id, :integer
  end
end
