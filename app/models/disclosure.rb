class Disclosure < ActiveRecord::Base
  include DisclosureCategory

  belongs_to :stock

  has_one :summary

  has_many :results_forecasts

  # デフォルト, 月次, 株式分割, 短信, 業績予想（期末）, 訂正
  enum category: {
    default: 0, monthly: 1, enum_split: 2, summary: 3,
    results_forecast_q4: 4, results_forecast_q2: 5, correction: 6,
  }

  class << self
    def one_year_disclosures(code)
      where(code: code)
        .where("release_date > ?", 1.year.ago)
        .order(id: :desc)
    end
  end

  def results_forecast_q4
    results_forecasts.find do |results_forecast|
      results_forecast.quarter == 4
    end
  end

  def pdf_path
    "/pdf/#{I18n.l(release_date, format: :ymd_short)}/#{pdf}"
  end
end
