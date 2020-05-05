class AddCountryToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :country, :integer, null: false, default: 0, after: :taisyaku_code

    add_index :stocks, [:country, :listed_date]
  end
end
