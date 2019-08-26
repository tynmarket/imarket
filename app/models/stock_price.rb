class StockPrice < ActiveRecord::Base
  LATEST = 0
  DAILY = 1

  scope :daily, -> { where term: DAILY }

  belongs_to :stock

  alias_attribute :fcf_ratio, :market_cap_fcf_ratio
end
