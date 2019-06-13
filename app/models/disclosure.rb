class Disclosure < ActiveRecord::Base
  include DisclosureCategory

  belongs_to :stock

  has_one :summary

  has_many :results_forecasts

  # kaminariだとincludesの前に指定する必要がある？
  # scope :display, -> { select("disclosures.id, disclosures.release, disclosures.name, disclosures.pdf, disclosures.title, disclosures.code") }

  def results_forecast_q4
    results_forecasts.find do |results_forecast|
      results_forecast.quarter == 4
    end
  end

  def pdf_path
    "/pdf/#{I18n.l(release_date, format: :ymd_short)}/#{pdf}"
  end
end
