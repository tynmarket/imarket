class EpsEstimate < ApplicationRecord
  scope :dow, -> { where(code: Stock.code_dow) }
  scope :dow_constituents, -> { where(code: codes_dow) }
  scope :n225, -> { where(code: Stock.code_n225) }
  scope :n225_r, -> { where(code: Stock.code_n225_r) }

  class << self
    def codes_dow
      %w(AAPL AXP BA CAT CSCO CVX DIS DOW GS HD IBM INTC JNJ JPM KO
         MCD MMM MRK MSFT NKE PFE PG RTX TRV UNH V VZ WBA WMT XOM)
    end
  end
end
