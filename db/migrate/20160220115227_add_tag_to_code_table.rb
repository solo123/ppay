class AddTagToCodeTable < ActiveRecord::Migration
  def change
    add_column :code_tables, :tag, :string
  end
end
