class StockPricesController < ApplicationController

  def per
    set_stock_price_data(:per)
  end

  def pbr
    set_stock_price_data(:pbr)
    render "per"
  end

  def fcf_ratio
    set_stock_price_data(:fcf_ratio)
    render "per"
  end

  private

  def set_stock_price_data(column)
    code = params[:id]
    today = Date.today

    @stock_prices = StockPrice
                    .daily
                    .where(code: code)
                    .where(date: spider_start_date..today)
                    .pluck(:date, column)

    # TODO 2011/07/01固定で良い？
    @dates_entire_period = TradingDayJp.between(spider_start_date, TradingDayJp.end_of_year(today))

    @dates_current_year = dates_current_year(today)
  end

  def spider_start_date
    Date.new 2011, 1, 1
  end

  def dates_current_year(today)
    @dates_entire_period.select do |d|
      d >= TradingDayJp.beginning_of_year(today)
    end
  end

  def ticks_entire_period(today)
    @dates_entire_period.map.with_index do |date, i|
      i if date == Date.new(2011, 7, 1) || TradingDayJp.beginning_of_year?(date) ||
           (date.year == today.year && TradingDayJp.end_of_year?(date))
    end.compact
  end
end
