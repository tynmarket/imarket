class LatestSummary < ActiveRecord::Base
  include FinancialInformation
  include FinancialRatio

  belongs_to :disclosure

end
