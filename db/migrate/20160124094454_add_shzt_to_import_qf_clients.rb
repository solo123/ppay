class AddShztToImportQfClients < ActiveRecord::Migration
  def change
    add_column :imp_qf_customers, :shzt, :string
  end
end
