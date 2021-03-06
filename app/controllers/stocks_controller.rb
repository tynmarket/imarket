class StocksController < ApplicationController

  def search
    find_stock

    if @stock
      find_data
      @action_name = "show"

      render action: @action_name
    else
      render action: "index"
    end
  end

  def show
    # TODO includes :stock_price_latestする？
    @stock = Stock.find_by(id: params[:id])

    if @stock
      find_data
    else
      render action: "index"
    end
  end

  private

  def find_stock
    query = params[:query]

    @stocks = Stock.search(query)

    if @stocks.size == 1
      @stock = @stocks.first
    elsif @stocks.size == 0
      disclosure = Disclosure.find_by(code: query)

      if disclosure
        code = disclosure.code
        @stock = Stock.new(id: code, code: code, name: disclosure.name)
      end
    end
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
