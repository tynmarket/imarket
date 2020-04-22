class StockSplitsController < ApplicationController
  def index
    codes = RevisionHistory.includes(constituent_stocks: :stock).last.constituent_stocks.map(&:code)
    @stock_splits = StockSplit
                    .includes(:stock)
                    .where(code: codes)
                    .order("id desc")
  end
end
