class EpsEstimatesChartsController < ApplicationController

  def show
    code = params[:code]
    @eps_estimates = EpsEstimate.where(code: code).order(:date)
    @stock_prices = StockPrice.daily.where(code: code).order(:date).pluck(:close)

    case code
    when Stock.code_n225
      chart_n225
    when Stock.code_dow
      chart_dow
    end
  end

  private

  def chart_n225
    @eps_estimates_n225 = @eps_estimates.pluck(:date, :current_year_eps)
    @dates = @eps_estimates_n225.map(&:first)
    @eps_estimates_n225_r = EpsEstimate.n225_r.order(:date).pluck(:date, :current_year_eps)

    # iMarket計算値の欠損値をnilで埋める
    insert_empty_data

    @eps_estimates_n225 = @eps_estimates_n225.map(&:last)

    render "eps_estimates/chart_n225"
  end

  def chart_dow
    # TODO 米国の祝日対応
    @dates = @eps_estimates.map(&:date)

    render "eps_estimates/chart_dow"
  end

  def insert_empty_data
    eps_estimates_n225_r = @eps_estimates_n225_r.to_h
    @eps_estimates_n225_r = @eps_estimates_n225.map do |eps_estimates|
      eps_estimates_n225_r[eps_estimates.first]
    end
  end
end
