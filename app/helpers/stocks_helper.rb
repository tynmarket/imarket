module StocksHelper
  include Utils::Constants

  def stocks_search?
    controller_name == "stocks" && action_name == "search"
  end

  def term_all?(term)
    term == "all"
  end

  def show_financial_value?(model, last_year)
    last_year.blank? || model.year >= last_year || term_annual?
  end

  def term_annual?
    params[:term] == "annual"
  end

  def hide_if_term_annual(summary)
    "hide" if term_annual? && !summary.q4?
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
    prev_summary = find_prev_summary(forecast, summaries)
    forecast_summary = summaries.first.disclosure_pdf.results_forecast_q4

    # 前年比がない
    !forecast.change_in_forecast_net_sales &&
      # 短信の業績予想ではない
      summaries.present? &&
      # 短信がある
      forecast.disclosure_id != summaries.first.disclosure_id &&
      # 前年同四半期の短信がある
      prev_summary &&
      # 短信の業績予想も前年比がある（会計基準の変更などはない）
      forecast_summary&.change_in_forecast_net_sales
  end

  def find_prev_summary(forecast, summaries)
    summaries.find do |summary|
      summary.year == forecast.year - 1 &&
        summary.month == forecast.month &&
        summary.quarter == 4
    end
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

  def activate_stock_tab(item)
    if params[:tab].blank? && item == "menu-summary"
      "active"
    else
      item == params[:tab] ? "active" : nil
    end
  end
end
