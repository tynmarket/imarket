class CreateBalanceSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_sheets do |t|
      t.integer :disclosure_id, null: false
      t.integer :stock_id, null: false
      t.string :code, limit: 6, null: false
      t.integer :year, limit: 2, null: false
      t.integer :month, limit: 1, null: false
      t.integer :quarter, limit: 1, null: false
      t.integer :interest_bearing_debt_fisco, comment: "有利子負債（FISCO）"
      t.integer :net_cash_fisco, comment: "ネットキャッシュ（FISCO）"

      t.timestamps

      t.index :disclosure_id
      t.index :code
      t.index :stock_id
    end
  end
end
