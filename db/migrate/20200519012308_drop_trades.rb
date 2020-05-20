class DropTrades < ActiveRecord::Migration[5.2]
  def change
    drop_table :trades
  end
end
