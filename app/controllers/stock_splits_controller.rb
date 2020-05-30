class StockSplitsController < ApplicationController
  def index
    from_date = Date.today.beginning_of_year - 1.years
    codes = Stock
            .joins(:constituent_stocks)
            .jp
            .pluck(:code)
            .uniq

    @stock_splits = StockSplit
                    .joins(:stock)
                    .includes(:stock)
                    .where("split_date > ?", from_date)
                    .order("split_date desc, stocks.code asc")

    @stock_splits_n225 = @stock_splits
                         .select { |stock_split| codes.include?(stock_split.code) }
  end
end
