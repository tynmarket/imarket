class CreateStocks < ActiveRecord::Migration[4.2]
  def change
    create_table :stocks do |t|
      t.string :code, limit: 6
      t.string :name
      t.string :search_name
      t.date :listed_date
      t.boolean :is_consolidated, default: true

      t.timestamps

      t.index :code, name: "index_stocks_code"
    end
  end
end
