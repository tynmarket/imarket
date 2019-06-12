class StockPricesController < ApplicationController

  def per
    set_stock_price_data(:per)
  end

  def pbr
    set_stock_price_data(:pbr)
    render "per"
  end

  private

  def set_stock_price_data(column)
    code = params[:id]
    today = Date.today

    @stock_prices = StockPrice
      .daily
      .where(code: code)
      .where(date: date_spider_start..today)
      .pluck(:date, column)

    # TODO 2011/07/01固定で良い？
    @dates_entire_period = TradingDayJp.between(date_spider_start, TradingDayJp.end_of_year(today))

    @dates_current_year = @dates_entire_period.select {|d| d >= TradingDayJp.beginning_of_year(today) }

    @ticks_current_year = @dates_current_year.map.with_index do |date, i|

      i if TradingDayJp.beginning_of_quarter?(date) || TradingDayJp.end_of_year?(date)

    end.compact

    @ticks_entire_period = @dates_entire_period.map.with_index do |date, i|

      i if date == Date.new(2011, 7, 1) || TradingDayJp.beginning_of_year?(date) ||
        (date.year == today.year && TradingDayJp.end_of_year?(date))

    end.compact
  end
end
