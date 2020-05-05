class HighestForecast < ApplicationRecord

  belongs_to :results_forecast

  def to_key
    f = results_forecast

    "#{f.code}#{f.year}#{f.month}#{f.quarter}"
  end
end
