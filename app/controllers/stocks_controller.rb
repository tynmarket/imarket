class StocksController < ApplicationController

  def search
    query = params[:query]

    @stocks = Stock.search(query)

    if @stocks.length > 1
      render action: 'index'
    else
      find_data @stocks.first, query
    end
  end

  def show
    id = params[:id]
    # TODO includes :stock_price_latestする？
    stock = Stock.find_by(id: id.to_i)

    find_data stock, id
  end

  private

  def find_data(stock, query)
    @debug = params[:debug] == "true"
    @term = params[:term]  # 表示期間
    @stock = stock

    unless @stock
      disclosure = Disclosure.select(:name).find_by(code: query)

      if disclosure
        # 銘柄のみ未登録
        @stock = Stock.new code: query, name: disclosure.name
      else
        render action: 'index'
        return
      end
    end

    @disclosures_monthly = @stock.disclosures_monthly.sort_by {|d| d.id * -1 }

    @summaries = find_summaries(@stock.code)

    @quarter_summaries, @latest_forecast, @quarter_results_forecast, @current_summaries =
      find_financial_informations(@stock.code, @summaries)

    # 初期表示は今期 〜 過去3期
    @last_year = get_last_year(@summaries) unless view_context.term_all?(@term)

    # TODO 本番でも遅延読み込みで表示？
    if development? || @debug
      @disclosures_debug = Disclosure.where(code: @stock.code).order(id: :desc)
    end

    render action: (@action_name = 'show')
  end

  def find_summaries(code)
    Summary
      .includes(:disclosure_pdf)
      .where(code: code)
      .sort_by {|s| s.disclosure_id * -1 }
  end

  def find_financial_informations(code, summaries)
    quarter_summaries = QuarterSummary.arrays summaries

    latest_forecast = LatestResultsForecast.find_latest(code, summaries.first)

    quarter_results_forecast = QuarterResultsForecast.create latest_forecast, summaries

    if latest_forecast.present?
      current_summaries = summaries.select do |summary|
        summary.year == latest_forecast.year
      end
    else
      current_summaries = []
    end

    return quarter_summaries, latest_forecast, quarter_results_forecast, current_summaries
  end

  def filter_by_year(financials, year)
    return [] if financials.blank?

    current_year = financials.first.year
    last_year = current_year - year

    financials.select {|financial| financial.year >= last_year }
  end

  def get_last_year(summaries)
    return if summaries.blank?

    current_year = summaries.first.year
    current_year - 3
  end

end
