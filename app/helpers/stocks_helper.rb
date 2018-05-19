module StocksHelper
  include Utils::Constants

  def stocks_search?
    controller_name == 'stocks' && action_name == 'search'
  end

  def term_all?(term)
    term == "all"
  end

  def term_annual?
    params[:term] == "annual"
  end

  def hide_if_term_annual(summary)
    if term_annual? && !summary.q4?
      return "hide"
    end
  end

  def thead_summary
    '<thead>
      <tr>
        <th class="w-period text-center text-middle">決算期</th>
        <th class="w-quarter text-center text-middle">四半期</th>
        <th class="w-net-sales text-center text-middle">売上高</th>
        <th class="w-income text-center text-middle">営業利益</th>
        <th class="w-income text-center text-middle">経常利益</th>
        <th class="w-income text-center text-middle">純利益</th>
        <th class="w-eps text-center text-middle">EPS</th>
        <th class="w-change text-center">営業<br>利益率</th>
        <th class="w-change text-center">経常<br>利益率</th>
        <th class="w-change text-center">売上高<br>前年比</th>
        <th class="w-change text-center">営業利益<br>前年比</th>
        <th class="w-change text-center">経常利益<br>前年比</th>
        <th class="w-change text-center">純利益<br>前年比</th>
      </tr>
    </thead>'.html_safe
  end

  def calc_change_in_forecast?(forecast, summaries)
    # 前年比がある
    return false if forecast.change_in_forecast_net_sales

    # 短信がない
    return false if summaries.blank?

    # 短信の業績予想
    return false if forecast.disclosure_id == summaries.first.disclosure_id

    # TODO 共通化
    prev_summary = summaries.find do |summary|
      summary.year == forecast.year - 1 &&
      summary.month == forecast.month &&
      summary.quarter == 4
    end

    # 前年同四半期の短信がない
    return false if prev_summary.blank?

    # 短信の業績予想も前年比がない（会計基準の変更など）
    forecast_summary = summaries.first.disclosure_pdf.results_forecast_q4
    return false if forecast_summary.blank? || forecast_summary.change_in_forecast_net_sales.blank?

    true
  end

  def per_in_stock(stock)
    per = stock.per || HYPHEN_SPACE

    "#{per} 倍"
  end

  def pbr_in_stock(stock)
    pbr = stock.pbr || HYPHEN_SPACE

    "#{pbr} 倍"
  end

  def options_select_per
    [[100, 100], [50, 50], [30, 30], [20, 20], [15, 15], [10, 10]].reverse
  end

  def options_select_pbr
    [[20, 20], [10, 10], [5, 5], [3, 3], [2, 2], [1, 1]].reverse
  end

end
