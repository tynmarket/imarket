class CashFlow < ApplicationRecord
  include FinancialInformation

  alias_attribute :operating_activities, :net_cash_provided_by_used_in_operating_activities
  alias_attribute :investment_activities, :net_cash_provided_by_used_in_investment_activities
  alias_attribute :financing_activities, :net_cash_provided_by_used_in_financing_activities
  alias_attribute :net_increase_in_cash, :net_increase_decrease_in_cash_and_cash_equivalents
  alias_attribute :prior_cash, :prior_cash_and_cash_equivalents
  alias_attribute :cash, :cash_and_cash_equivalents
end
