class AddMarketCapFcfRatio < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_prices, :market_cap_fcf_ratio, :float, after: :pbr
  end
end
