class DisclosuresController < ApplicationController

  def index
    date = params[:date]
    show = params[:show]
    now = Time.now

    if date
      begin
        @date = Date.parse date
      rescue
        @date = now.to_date
      end
      page = params[:page].to_i
    elsif (0...7).include? now.hour
      @date = now.to_date - 1.day
      page = 1
    else
      @date = now.to_date
      page = 1
    end

    @last_updated = SystemStatus.stock_price_last_updated

    @disclosures = Disclosure
                   .includes(:summary, :results_forecasts, stock: :stock_price_latest)
                   .where(release_date: @date...@date + 1)
                   .page(page)
                   .order(id: :desc)
  end

end
