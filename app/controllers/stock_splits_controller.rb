class StockSplitsController < ApplicationController
  def index
    codes = RevisionHistory
            .includes(constituent_stocks: :stock)
            .last
            .constituent_stocks
            .map(&:code)

    @stock_splits = StockSplit
                    .includes(:stock)
                    .order("id desc")

    @stock_splits_n225 = @stock_splits
                         .select { |stock_split| codes.include?(stock_split.code) }
  end
end
