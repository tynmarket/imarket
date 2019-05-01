class CreateCashFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_flows do |t|
      t.integer :disclosure_id, null: false
      t.integer :stock_id, null: false
      t.string :code, limit: 6, null: false
      t.integer :year, limit: 2, null: false
      t.integer :month, limit: 1, null: false
      t.integer :quarter, limit: 1, null: false
      t.integer :net_cash_provided_by_used_in_operating_activities, null: false
      t.integer :net_cash_provided_by_used_in_investment_activities, null: false
      t.integer :net_cash_provided_by_used_in_financing_activities, null: false
      t.integer :net_increase_decrease_in_cash_and_cash_equivalents, null: false
      t.integer :cash_and_cash_equivalents, null: false

      t.timestamps
    end
  end
end
