class CashFlow < ApplicationRecord
  include FinancialInformation

  alias_attribute :operating_activities, :net_cash_provided_by_used_in_operating_activities
  alias_attribute :investment_activities, :net_cash_provided_by_used_in_investment_activities
  alias_attribute :financing_activities, :net_cash_provided_by_used_in_financing_activities
  alias_attribute :net_increase_in_cash, :net_increase_decrease_in_cash_and_cash_equivalents
  alias_attribute :prior_cash, :prior_cash_and_cash_equivalents
  alias_attribute :cash, :cash_and_cash_equivalents

  def net_increase_in_cash(prev_cash_flow = nil)
    return net_increase_decrease_in_cash_and_cash_equivalents unless prev_cash_flow

    if quarter == 4 && prev_cash_flow.quarter == 4
      # 通期のみの場合は現金及び同等物の期末残高の差分を計算する
      cash - prev_cash_flow.cash
    else
      net_increase_decrease_in_cash_and_cash_equivalents
    end
  end
end
