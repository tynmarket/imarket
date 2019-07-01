module Api
  class StockPricesController < ApplicationController
    def show
      code = params[:code]
      date = params[:date]
      @stock_price = StockPrice
                     .joins(:stock)
                     .daily
                     .where(stocks: { code: code })
                     .where(date: date)
                     .first

      render json: (@stock_price || {})
    end
  end
end
