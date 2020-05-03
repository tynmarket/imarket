class StockPrice < ActiveRecord::Base
  LATEST = 0
  DAILY = 1

  belongs_to :stock

  enum term: { latest: 0, daily: 1 }

  alias_attribute :fcf_ratio, :market_cap_fcf_ratio
end
