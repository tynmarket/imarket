class StockPrice < ActiveRecord::Base

  LATEST = 0
  DAILY = 1

  scope :daily, -> { where term: DAILY }

  belongs_to :stock

end