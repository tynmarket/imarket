class StocksController < ApplicationController

  def search
    query = params[:query]

    @stocks = Stock.search(query)

    if @stocks.length > 1
      render action: "index"
    else
      find_data @stocks.first, query
    end
  end

  def show
    id = params[:id]

    # TODO includes :stock_price_latestする？
    @stock = find_stock(id)

    if @stock
      find_data
    else
      render action: "index"
    end
  end

  private

  def find_stock(id)
    stock = Stock.find_by(id: id.to_i)

    return stock if stock

    disclosure = Disclosure.select(:name).find_by(code: id)
    Stock.new id: id, code: id, name: disclosure.name if disclosure
  end

  # rubocop:disable Metrics/AbcSize
  def find_data
    @debug = params[:debug] == "true"
    @term = params[:term] # 表示期間

    @disclosures_monthly = @stock.for_disclosures_monthly

    @summaries = find_summaries(@stock.code)
    @cash_flows = find_cash_flows(@stock.code)
    @cash_flows_only_q4 = @cash_flows.all?(&:q4?)

    @quarter_summaries, @latest_forecast, @quarter_results_forecast,
      @current_summaries, @quarter_cash_flows =
      find_financial_informations(@stock.code, @summaries, @cash_flows)

    # 初期表示は今期 〜 過去3期
    @last_year = get_last_year(@summaries) unless view_context.term_all?(@term)

    @disclosures = Disclosure.one_year_disclosures(@stock.code)
    @action_name = "show"

    render action: @action_name
  end
  # rubocop:enable Metrics/AbcSize

  def find_summaries(code)
    Summary
      .includes(:disclosure_pdf)
      .where(code: code)
      .sort_by { |s| s.disclosure_id * -1 }
  end

  def find_cash_flows(code)
    CashFlow
      .includes(:disclosure_pdf)
      .where(code: code)
      .sort_by { |s| s.disclosure_id * -1 }
  end

  def find_financial_informations(code, summaries, cash_flows)
    quarter_summaries = QuarterSummary.arrays summaries
    quarter_cash_flows = QuarterCashFlow.arrays cash_flows

    latest_forecast = LatestResultsForecast.find_latest(code, summaries.first)

    quarter_results_forecast = QuarterResultsForecast.create latest_forecast, summaries

    current_summaries =
      if latest_forecast.present?
        summaries.select do |summary|
          summary.year == latest_forecast.year
        end
      else
        []
      end

    [quarter_summaries, latest_forecast, quarter_results_forecast,
     current_summaries, quarter_cash_flows]
  end

  def filter_by_year(financials, year)
    return [] if financials.blank?

    current_year = financials.first.year
    last_year = current_year - year

    financials.select { |financial| financial.year >= last_year }
  end

  def get_last_year(summaries)
    return if summaries.blank?

    current_year = summaries.first.year
    current_year - 3
  end

end
