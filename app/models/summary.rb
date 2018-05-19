class Summary < ActiveRecord::Base
  include FinancialInformation
  include FinancialRatio

  belongs_to :disclosure

  def results_forecast_dummy
    dummy = ResultsForecast.new
    dummy.year = quarter == 4 ? year + 1 : year if year && quarter
    dummy.month = month
    dummy.quarter = 4

    dummy
  end

end
