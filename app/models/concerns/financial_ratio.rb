module FinancialRatio

  # 売上高営業利益率〜売上高経常利益率
  [:operating_income, :ordinary_income].each do |method|
    define_method "net_sales_#{method}_ratio" do
      (send(method).to_f / net_sales).round(3) if net_sales && net_sales > 0 && send(method)
    end
  end

  # 予想売上高営業利益率〜予想売上高経常利益率
  [:operating_income, :ordinary_income].each do |method|
    define_method "forecast_net_sales_#{method}_ratio" do
      forecast_method = "forecast_#{method}"

      (send(forecast_method).to_f / forecast_net_sales).round(3) if forecast_net_sales && forecast_net_sales > 0 && send(forecast_method)
    end
  end

  # 売上高進捗率〜純利益進捗率
  [:net_sales, :operating_income, :ordinary_income, :net_income].each do |method|
    define_method "#{method}_progress_ratio" do |results_forecast|
      forecast_method = "forecast_#{method}"

      if send(method) && results_forecast.try(forecast_method)
        if send(method) <= 0 || results_forecast.send(forecast_method) <= 0
          0.0
        else
          ((send(method).to_f / results_forecast.send(forecast_method)) * 100).round(1)
        end
      end
    end
  end

end
