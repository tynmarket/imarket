class DisclosuresController < ApplicationController

  def index
    @date = find_date
    page = find_page
    @last_updated = SystemStatus.stock_price_last_updated

    @disclosures = Disclosure
                   .includes(:summary, :results_forecasts, stock: :stock_price_latest)
                   .where(release_date: @date...@date + 1)
                   .page(page)
                   .order(id: :desc)

    @favorite_code_hash = logged_in? && current_user.favorite_code_hash || {}
    @highest_forecast_results_forecast_id = HighestForecast
                                            .where(date: @date)
                                            .pluck(:results_forecast_id)
                                            .map { |id| [id, true] }
                                            .to_h
  end

  def find_date
    date = params[:date]
    now = Time.now

    if date
      Date.parse date rescue now.to_date
    elsif (0...7).include? now.hour
      now.to_date - 1.day
    else
      now.to_date
    end
  end

  def find_page
    params[:page] || 1
  end

end
