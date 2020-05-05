class HighestForecastsController < ApplicationController

  def index
    highest_forecasts = HighestForecast
                        .includes(results_forecast: :disclosure)
                        .order("date desc, id desc")

    @highest_forecasts = filter_duplications(highest_forecasts)
  end

  private

  def filter_duplications(highest_forecasts)
    prev_highest_forecasts = {}
    first_highest_forecast_index = []

    highest_forecasts.reverse.each_with_index do |highest_forecast, i|
      key = highest_forecast.to_key

      unless prev_highest_forecasts[key]
        prev_highest_forecasts[key] = highest_forecast
        first_highest_forecast_index << i
      end
    end

    highest_forecasts
      .reverse
      .select
      .with_index { |_, i| first_highest_forecast_index.include?(i) }
      .reverse
  end
end
