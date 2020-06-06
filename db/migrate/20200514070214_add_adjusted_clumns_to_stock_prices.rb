class AddAdjustedClumnsToStockPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_prices, :open_adjusted, :float, after: :pbr
    add_column :stock_prices, :high_adjusted, :float, after: :open_adjusted
    add_column :stock_prices, :low_adjusted, :float, after: :high_adjusted
    add_column :stock_prices, :volume_adjusted, :integer, after: :close_adjusted
  end
end
