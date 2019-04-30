class QuarterCashFlow
  include FinancialInformation

  attr_reader :year, :quarter, :month, :cash_flow

  class << self
    def arrays(cash_flows)
      return cash_flows if cash_flows.blank?

      cash_flows.map.with_index do |cash_flow, i|
        new cash_flow, cash_flows[i + 1]
      end
    end
  end

  def initialize(cash_flow, prev_quarter_cash_flow)
    @cash_flow = cash_flow
    @prev_quarter_cash_flow = prev_quarter_cash_flow
    @year = @cash_flow.year
    @quarter = @cash_flow.quarter
    @month = @cash_flow.month
  end

  # 営業キャッシュ〜現金及び同等物の増減額
  @@methods = [:operating_activities, :investment_activities, :financing_activities, :net_increase_in_cash]

  @@methods.each do |method|
    define_method method do
      if quarter == 1
        if @prev_quarter_cash_flow.try(:quarter) == 0  # 前期が0Q
          if @cash_flow.send(method) && @prev_quarter_cash_flow.send(method)
            @cash_flow.send(method) - @prev_quarter_cash_flow.send(method)
          end
        else
          @cash_flow.send(method)
        end
      elsif quarter == 0
        @cash_flow.send(method)
      elsif @prev_quarter_cash_flow &&  # 決算期の変更
        (year != @prev_quarter_cash_flow.year ||  # 年度の途中から年度が変わっている/四半期のキャッシュフローの開示はない
          (year == @prev_quarter_cash_flow.year && month != @prev_quarter_cash_flow.month))  # 年度の途中から決算月が変わっている
        @cash_flow.send(method)
      elsif @cash_flow.send(method) && @prev_quarter_cash_flow.try(method)
        @cash_flow.send(method) - @prev_quarter_cash_flow.send(method)
      end
    end
  end

end
