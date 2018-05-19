class DisclosuresController < ApplicationController

  def index
    date = params[:date]
    show = params[:show]
    now = Time.now

    if date
      @date = Date.parse date
      page = params[:page].to_i
    elsif (0...7).include? now.hour
      @date = now.to_date - 1.day
      page = 1
    else
      @date = now.to_date
      page = 1
    end

    @last_updated = SystemStatus.stock_price_last_updated

    activate_tab

    @disclosures = Disclosure
      .includes(:summary, :results_forecasts, stock: :stock_price_latest)
      .where(release_date: @date...@date + 1)
      .page(page)
      .order(id: :desc)
  end

  private

  def activate_tab
    tab = params[:tab]

    case tab
    when "finance"
      @class_finance = "active";
    when "monthly"
      @class_monthly = "active";
    when "all"
      @class_all = "active";
    else
      @class_finance = "active";
    end
  end

end
