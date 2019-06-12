module DisclosuresHelper
  include Utils::Constants

  def today_to_prev_month
    today = Date.today
    (today.prev_month + 1..today).to_a.reverse
  end

  def date_color(date)
    return "blue" if date.saturday?

    "red" if date.sunday? || HolidayJp.holiday?(date)
  end

  def release_time(disclosure)
    return unless disclosure && disclosure.release_date

    disclosure.release_date.strftime(HM_C)
  end

  def release_date(date)
    date.strftime YMD_KA_LA
  end

  def forecast?(summary, forecasts)
    summary.blank? && forecasts.present?
  end

  def per_in_disclosure(disclosure)
    per = disclosure.stock.try(:per) || HYPHEN_SPACE
    "#{per} 倍"
  end

  def pbr_in_disclosure(disclosure)
    pbr = disclosure.stock.try(:pbr) || HYPHEN_SPACE
    "#{pbr} 倍"
  end

  def disclosure_table
    DisclosureTable.new
  end

  class DisclosureTable
    def thead
      thead = "<thead class='#{@rendered ? "space" : nil}'>
          <tr>
            <th class='w_release text-center'>#{@rendered ? nil : "時刻"}</th>
            <th class='w_name text-center'>#{@rendered ? nil : "会社名"}</th>
            <th class='w_pdf text-center'>#{@rendered ? nil : "PDF"}</th>
            <th class='w_period text-center'>#{@rendered ? nil : "決算期"}</th>
            <th class='w_quarter text-center'>#{@rendered ? nil : "四半期"}</th>
            <th class='w_net_sales text-center' colspan='2'>#{@rendered ? nil : "売上高"}</th>
            <th class='w_income text-center' colspan='2'>#{@rendered ? nil : "営業利益"}</th>
            <th class='w_income text-center' colspan='2'>#{@rendered ? nil : "経常利益"}</th>
            <th class='w_income text-center' colspan='2'>#{@rendered ? nil : "純利益"}</th>
            <th class='w_eps text-center'>#{@rendered ? nil : "EPS"}</th>
            <th class='w_code text-center'>#{@rendered ? nil : "コード"}</th>
          </tr>
        </thead>".html_safe

      @rendered = true unless @rendered

      thead
    end
  end

  def activate_disclosure_tab(item)
    if params[:tab].blank? && item == "finance"
      "active"
    else
      item == params[:tab] ? "active" : nil
    end
  end
end
