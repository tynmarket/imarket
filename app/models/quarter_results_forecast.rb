#
# 業績予想 - 実績
#
class QuarterResultsForecast
  include FinancialInformation
  include FinancialRatio

  attr_reader :year, :quarter, :month, :latest_forecast

  class << self

    def create(latest_forecast, summaries)
      new(latest_forecast, summaries) if latest_forecast.present? # 予想のみある場合は可とする
    end

  end

  def initialize(latest_forecast, summaries)
    @latest_forecast = latest_forecast
    @latest_summary = summaries.first
    @summaries = summaries

    @year = @latest_forecast.year
    @quarter = @latest_forecast.quarter
    @month = @latest_forecast.month
  end

  def quarter_name_forecast
    if next_year?
      quarter_name_forecast_from(1)
    elsif @latest_summary.quarter == 3
      "4Q予想"
    elsif @latest_summary.quarter == 2
      quarter_name_forecast_from(3)
    elsif @latest_summary.quarter == 1
      quarter_name_forecast_from(2)
    end
  end

  # TODO @methodsなくす
  # 予想売上高〜予想EPS
  @methods = [:forecast_net_sales, :forecast_operating_income, :forecast_ordinary_income,
    :forecast_net_income, :forecast_net_income_per_share]

  @methods.each do |method|
    define_method method do
      if next_year?
        @latest_forecast.send(method)
      elsif @latest_forecast.send(method) && @latest_summary.send(not_forecast(method))
        @latest_forecast.send(method) - @latest_summary.send(not_forecast(method))
      end
    end
  end

  # 予想売上高前年比〜予想純利益前年比
  @methods = [:change_in_forecast_net_sales, :change_in_forecast_operating_income,
    :change_in_forecast_ordinary_income, :change_in_forecast_net_income]

  @methods.each do |method|
    define_method method do
      # 来季予想
      if next_year?
        change_in_forecast_value = @latest_forecast.send method

        # 累計と同じ
        return change_in_forecast_value if change_in_forecast_value

        # 計算する
        return @latest_forecast.send "calc_#{method}", @summaries
      end

      forecast_value = send(not_change_in(method)) # 四半期ベースの予想

      return unless forecast_value

      prev_summaries = @summaries.select do |summary|
        summary.year == year - 1 && summary.month == month &&
          summary.quarter >= @latest_summary.quarter # 去年の累計、@latest_summaryがないケースは弾かれてる
      end

      return unless prev_summaries_exist?(prev_summaries) # 前年の値が計算出来ない

      value_method = not_change_in_forecast(method)
      to_value = prev_summaries.first.send(value_method)
      from_value = prev_summaries.last.send(value_method)
      prev_value = to_value - from_value if to_value && from_value

      return unless prev_value

      if forecast_value > 0 && prev_value > 0
        ((forecast_value.to_f - prev_value) / prev_value).round(3)
      end
    end
  end

  private

  def next_year?
    !@latest_summary || @latest_summary.year != year # 短信がない場合も本決算後とする
  end

  def quarter_name_forecast_from(from)
    "#{from}Q - #{quarter}Q<br>予想"
  end

  def prev_summaries_exist?(prev_summaries)
    if @latest_summary.quarter == 1
      prev_summaries.size == 4
    elsif @latest_summary.quarter == 2
      prev_summaries.size == 3
    elsif @latest_summary.quarter == 3
      prev_summaries.size == 2
    end
  end

  def not_forecast(forcast_metnod)
    forcast_metnod.to_s.sub("forecast_", "").to_sym
  end

  def not_change_in(change_in_method)
    change_in_method.to_s.sub("change_in_", "").to_sym
  end

  def not_change_in_forecast(change_in_forecast_method)
    change_in_forecast_method.to_s.sub("change_in_forecast_", "").to_sym
  end
end
