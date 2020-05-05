class ResultsForecast < ActiveRecord::Base
  include FinancialInformation
  include FinancialRatio

  belongs_to :disclosure

  def change_in_forecast_or_calc(attr, summary)
    send("change_in_forecast_#{attr}") || calc_change_in_forecast(attr, summary)
  end

  def calc_change_in_forecast(attr, summary)
    forecast_value = send("forecast_#{attr}")
    prev_value = summary.send(attr)

    forecast_value && prev_value &&
      (forecast_value.to_f - prev_value) / prev_value
  end
end
