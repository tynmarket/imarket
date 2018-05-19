class LatestResultsForecast < ActiveRecord::Base
  include FinancialInformation
  include FinancialRatio

  belongs_to :disclosure

  def self.find_latest(code, latest_summary)
    latest = where(code: code).take

    return unless latest

    # 値が空の業績予想の修正は表示するので返す
    if latest.values_present? ||
        (latest_summary.present? && latest.disclosure_id != latest_summary.disclosure_id)
      latest
    end
  end


  def quarter_name_forecast
    "#{quarter}Q予想" if quarter
  end

  def values_present?
    !!(forecast_net_sales || forecast_operating_income || forecast_ordinary_income || forecast_net_income || forecast_net_income_per_share)
  end

  [:net_sales, :operating_income, :ordinary_income, :net_income, :net_income_per_share].each do |method|
    forecast_method = "forecast_#{method}"

    define_method "calc_change_in_#{forecast_method}" do |summaries|
      prev_summary = summaries.find do |summary|
        summary.year == year - 1 &&
        summary.month == month &&
        summary.quarter == 4
      end

      return unless prev_summary

      forecast_value = send(forecast_method)
      prev_value = prev_summary.send(method)

      return unless forecast_value && prev_value

      # TODO 共通化
      if forecast_value > 0 && prev_value > 0
        ((forecast_value.to_f - prev_value) / prev_value).round(3)
      end
    end
  end

end
