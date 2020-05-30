class StockSplitsController < ApplicationController
  def index
    from_date = Date.today.beginning_of_year - 1.years
    codes = Stock
            .joins(:constituent_stocks)
            .jp
            .pluck(:code)
            .uniq

    @stock_splits = StockSplit
                    .includes(:stock)
                    .where("split_date > ?", from_date)
                    .order("id desc")

    @stock_splits_n225 = @stock_splits
                         .select { |stock_split| codes.include?(stock_split.code) }
  end
end
