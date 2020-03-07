class PriceIntraday < ApplicationRecord
  enum period: { one: 1, ten: 10, hour: 60 }

  scope :n225f, -> { where(code:  "N225F") }

  class << self
    def ohlc(code, period, from, to)
      send(code)
        .send(period)
        .where("datetime >= ?", from)
        .where("datetime <= ?", to)
        .pluck(:datetime, :open, :high, :low, :close)
        .map{ |v| [v[0].to_i * 1000, v[1], v[2], v[3], v[4]] }
    end
  end
end
