class AddIndexToStocks < ActiveRecord::Migration[6.0]
  def change
    add_index :stocks, :listed_date
  end
end
