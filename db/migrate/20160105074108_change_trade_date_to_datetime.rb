class ChangeTradeDateToDatetime < ActiveRecord::Migration
  def self.up
    change_column :trades, :trade_date, :datetime
    change_column :clearings, :trade_date, :datetime

  end

  def self.down
    change_column :trades, :trade_date, :string
    change_column :clearings, :trade_date, :string

  end
end
