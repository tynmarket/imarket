class AddYtdToStockPrices < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_prices, :ytd, :float, after: :market_cap_fcf_ratio
  end
end
