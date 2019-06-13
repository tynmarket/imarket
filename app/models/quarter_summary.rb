class QuarterSummary
  include FinancialInformation
  include FinancialRatio

  attr_reader :year, :quarter, :month, :summary

  class << self
    def arrays(summaries)
      return summaries if summaries.blank?

      summaries.map.with_index do |summary, i|
        new summary, summaries[i + 1]
      end
    end
  end

  def initialize(summary, prev_quarter_summary)
    @summary = summary
    @prev_quarter_summary = prev_quarter_summary
    @year = @summary.year
    @quarter = @summary.quarter
    @month = @summary.month
  end

  # 売上高〜EPS
  @methods = [:net_sales, :operating_income, :ordinary_income, :net_income, :net_income_per_share]

  # TODO 歯抜けの場合は？
  @methods.each do |method|
    define_method method do
      if quarter == 1
        if @prev_quarter_summary.try(:quarter) == 0 # 前期が0Q
          if @summary.send(method) && @prev_quarter_summary.send(method)
            @summary.send(method) - @prev_quarter_summary.send(method)
          end
        else
          @summary.send(method)
        end
      elsif quarter == 0
        @summary.send(method)
      elsif @prev_quarter_summary && # 決算期の変更
            (year != @prev_quarter_summary.year || # 年度の途中から年度が変わっている
              (year == @prev_quarter_summary.year && month != @prev_quarter_summary.month)) # 年度の途中から決算月が変わっている
        @summary.send(method)
      elsif @summary.send(method) && @prev_quarter_summary.try(method)
        @summary.send(method) - @prev_quarter_summary.send(method)
      end
    end
  end

  # 売上高前年比〜純利益前年比
  @change_in_methods = [:net_sales, :operating_income, :ordinary_income, :net_income]

  @change_in_methods.each do |method|
    define_method "change_in_#{method}" do |prev_year_quarter_summary|
      if prev_year_quarter_summary && # 前年同四半期
         year - 1 == prev_year_quarter_summary.year &&
         month == prev_year_quarter_summary.month &&
         quarter == prev_year_quarter_summary.quarter &&
         send(method) && send(method) > 0 &&
         prev_year_quarter_summary.send(method) && prev_year_quarter_summary.send(method) > 0
        ((send(method).to_f - prev_year_quarter_summary.send(method)) / prev_year_quarter_summary.send(method)).round(3)
      end
    end
  end

end
