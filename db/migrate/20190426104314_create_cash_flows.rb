class CreateCashFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_flows do |t|
      t.integer :disclosure_id, null: false
      t.integer :stock_id, null: false
      t.string :code, limit: 6, null: false
      t.integer :year, limit: 2, null: false
      t.integer :month, limit: 1, null: false
      t.integer :quarter, limit: 1, null: false
      t.integer :net_cash_provided_by_used_in_operating_activities # キャッシュフローの値が歯抜けの可能性もある
      t.integer :net_cash_provided_by_used_in_investment_activities
      t.integer :net_cash_provided_by_used_in_financing_activities
      t.integer :net_increase_decrease_in_cash_and_cash_equivalents # 短信から取得した場合、値は設定されない
      t.integer :cash_and_cash_equivalents

      t.timestamps

      t.index :disclosure_id
      t.index :code
      t.index :stock_id
    end
  end
end
