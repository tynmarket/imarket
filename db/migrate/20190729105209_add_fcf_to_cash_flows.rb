class AddFcfToCashFlows < ActiveRecord::Migration[5.2]
  def change
    add_column :cash_flows, :fcf, :integer, after: :net_cash_provided_by_used_in_investment_activities
  end
end
