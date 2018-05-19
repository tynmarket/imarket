class CreateStockPrices < ActiveRecord::Migration[4.2]
  def change
    create_table :stock_prices do |t|
      t.string :code, limit: 6
      t.integer :term, limit: 1
      t.date :date
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.integer :volume
      t.integer :value
      t.float :change
      t.float :change_rate
      t.integer :market_cap
      t.integer :shares, limit: 8
      t.float :per
      t.float :pbr
      t.float :close_adjusted
      t.integer :stock_id

      t.timestamps

      t.index [:term, :code, :date, :per], name: "index_stock_prices_term_code_date_per"
      t.index [:term, :code, :date, :close], name: "index_stock_prices_term_code_date_close"
      t.index [:term, :stock_id], name: "index_stock_prices_term_stock_id"
    end
  end
end
