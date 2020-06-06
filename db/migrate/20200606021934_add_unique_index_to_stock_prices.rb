class AddUniqueIndexToStockPrices < ActiveRecord::Migration[6.0]
  def change
    add_index :stock_prices, [:term, :code, :date], unique: true
  end
end
