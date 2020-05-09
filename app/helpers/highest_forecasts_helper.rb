module HighestForecastsHelper

  def per_in_highest_forecasts(disclosure)
    per = floor_per(disclosure.stock.try(:per)) || HYPHEN_SPACE
    "#{per} 倍"
  end

  def floor_per(num)
    return unless num
    num >= 100 ? num.floor : num
  end
end
