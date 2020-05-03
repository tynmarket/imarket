class EpsEstimatesChartsController < ApplicationController

  def show
    code = params[:code]
    @eps_estimates = EpsEstimate.where(code: code).order(:date)

    case code
    when Stock.code_n225, Stock.code_n225_r
      chart_n225
    when Stock.code_dow
      chart_dow
    end
  end

  private

  def chart_n225
    @eps_estimates_n225 = @eps_estimates.pluck(:date, :current_year_eps)
    @dates = @eps_estimates_n225.map(&:first)
    @stock_prices = StockPrice
                    .daily
                    .where(code: Stock.code_n225)
                    .where("date >= ?", @dates.first)
                    .order(:date)
                    .pluck(:close)

    @eps_estimates_n225 = @eps_estimates_n225.map(&:last)

    render "eps_estimates/chart_n225"
  end

  def chart_dow
    # TODO 米国の祝日対応
    @eps_estimates_dow = @eps_estimates.pluck(:date, :current_year_eps, :next_year_eps)
    @dates = @eps_estimates_dow.map(&:first)
    # ダウの日付は1日ずらす
    @stock_prices = StockPrice
                    .daily
                    .where(code: Stock.code_dow)
                    .where("date < ?", @dates.last)
                    .order("date desc")
                    .limit(@dates.size)
                    .pluck(:close)
                    .reverse

    @eps_estimates_current = @eps_estimates_dow.map(&:second)
    @eps_estimates_next = @eps_estimates_dow.map(&:last)

    render "eps_estimates/chart_dow"
  end
end
