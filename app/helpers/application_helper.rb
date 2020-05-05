module ApplicationHelper
  include Utils::Constants
  include Utils::UtilMethod

  def release_notes
    <<~EOS.html_safe
      （5/5）<a href="/highest_forecasts">過去最高益銘柄</a> を表示するようにしました。<br>
      （5/3）予想EPSを <a href="/eps_estimates?tab=n225-chart">チャート</a> で指数と比較して表示するようにしました。<br>
      （4/28）<a href="/eps_estimates">日経平均</a> と <a href="/eps_estimates?tab=dow">ダウ平均</a> の予想EPSを表示するようにしました。<br>
       <span style="color:white;">（4/28）</span>日経平均は公式のものとiMarket算出の2種類を載せています。
    EOS
  end

  def body_class
    "#{controller_name} #{'logged_in' if logged_in?}"
  end

  def google?
    return false unless current_user

    current_user.authentications.first.provider == "google"
  end

  def release_date_s(disclosure)
    disclosure.release_date.strftime YMD_S
  end

  def link_to_pdf(disclosure, text)
    if disclosure&.release_date && disclosure.pdf
      "<a href='#{disclosure.pdf_path}' target='_blank'>#{text}</a>".html_safe
    elsif text
      text.html_safe
    end
  end

  def link_to_stock(model)
    "<a href='/stocks/#{model.code}' target='_blank'>#{model.code}</a>".html_safe
  end

  # rubocop:disable Metrics/AbcSize
  def link_to_other_services(model, full = false)
    link_to_detail(model, full) + link_to_chart(model, full) +
      link_to_profile(model, full) + link_to_margin(model, full) +
      link_to_shikiho(model, full) + link_to_ifis(model, full) +
      link_to_taiho(model, full) + link_to_karauri(model, full) +
      link_to_balance(model, full) + link_to_pcsl(model, full) +
      link_to_yuho(model, full) + link_to_pts(model, full) +
      link_to_sbi(model, full) + link_to_kabutan(model, full) +
      link_to_fisco(model, full) + link_to_shikiho(model, full) +
      link_to_getsuji(model, full)
  end
  # rubocop:enable Metrics/AbcSize

  def link_to_other_services_short(model, full = false)
    link_to_detail(model, full) + link_to_chart(model, full) +
      link_to_profile(model, full) + link_to_shikiho(model, full)
  end

  def link_class_name(class_name, full = false)
    "link-#{class_name} #{'full-service-name' if full}"
  end

  def link_to_detail(model, full = false)
    "<a class=#{link_class_name('detail', full)} href='http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{model.code}' target='_blank'>\
    <span>#{full ? '詳細' : 'Y!'}</span></a>".html_safe
  end

  def link_to_chart(model, full = false)
    "<a class=#{link_class_name('chart', full)} href='http://stocks.finance.yahoo.co.jp/stocks/chart/?code=#{model.code}' target='_blank'>\
    <span class='#{'glyphicon glyphicon-signal' unless full}'>#{'チャート' if full}</span></a>".html_safe
  end

  def link_to_profile(model, full = false)
    "<a class=#{link_class_name('profile', full)} href='http://stocks.finance.yahoo.co.jp/stocks/profile/?code=#{model.code}' target='_blank'>\
    <span>#{full ? '企業情報' : '企'}</span></a>".html_safe
  end

  def link_to_margin(model, full = false)
    to = Date.today
    from = to.last_year.next_week

    "<a class=#{link_class_name('margin', full)} href='http://info.finance.yahoo.co.jp/history/margin/?code=#{model.code}&sy=#{from.year}&sm=#{from.month}&sd=#{from.day}&ey=#{to.year}&em=#{to.month}&ed=#{to.day}' target='_blank'>\
    <span>#{full ? '信用残' : '信'}</span></a>".html_safe
  end

  def link_to_ifis(model, full = false)
    "<a class=#{link_class_name('ifis', full)} href='http://kabuyoho.ifis.co.jp/index.php?action=tp1&sa=report_chg&bcode=#{model.code}' target='_blank'>\
    <span>#{full ? 'コンセンサス' : 'コ'}</span></a>".html_safe
  end

  def link_to_taiho(model, full = false)
    "<a class=#{link_class_name('taiho', full)} href='https://maonline.jp/db/shareholding_reports?query%5Bisname_or_issyokencode_or_company_iscode_start%5D=#{model.code}' target='_blank'>\
    <span>#{full ? '大量保有' : '大'}</span></a>".html_safe
  end

  def link_to_karauri(model, full = false)
    "<a class=#{link_class_name('karauri', full)} href='http://karauri.net/#{model.code}/' target='_blank'>\
    <span>#{full ? '空売り' : '空'}</span></a>".html_safe
  end

  def link_to_balance(model, full = false)
    "<a class=#{link_class_name('balance', full)} href='http://www.taisyaku.jp/search/detail/balance/#{model.taisyaku_code}' target='_blank'>\
    <span>#{full ? '融資・貸株' : '融'}</span></a>".html_safe
  end

  def link_to_pcsl(model, full = false)
    "<a class=#{link_class_name('pcsl', full)} href='https://www.nisshokin.com/#{model.code}/' target='_blank'>\
    <span>#{full ? '逆日歩' : '逆'}</span></a>".html_safe
  end

  def link_to_yuho(model, full = false)
    "<a class=#{link_class_name('yuho', full)} href='http://www.kabupro.jp/yuho/#{model.code}.htm' target='_blank'>\
    <span>#{full ? '有報' : '有'}</span></a>".html_safe
  end

  def link_to_pts(model, full = false)
    "<a class=#{link_class_name('pts', full)} href='http://www.morningstar.co.jp/StockInfo/pts/info/#{model.code}' target='_blank'>\
    <span>#{full ? 'PTS' : 'P'}</span></a>".html_safe
  end

  def link_to_sbi(model, full = false)
    "<a class=#{link_class_name('sbi', full)} href='https://site2.sbisec.co.jp/ETGate/?_ControlID=WPLETsiR001Control&_PageID=WPLETsiR001Idtl10&_ActionID=stockDetail&i_stock_sec=#{model.code}&stock_sec_code_mul=#{model.code}' target='_blank'>\
    <span>#{full ? 'SBI' : 'S'}</span></a>".html_safe
  end

  def link_to_kabutan(model, full = false)
    "<a class=#{link_class_name('kabutan', full)} href='https://kabutan.jp/stock/?code=#{model.code}' target='_blank'>\
    <span>#{full ? '株探' : '探'}</span></a>".html_safe
  end

  def link_to_fisco(model, full = false)
    "<a class=#{link_class_name('fisco', full)} href='https://web.fisco.jp/platform/companies/0#{model.code}00/cashflow' target='_blank'>\
    <span>#{full ? 'FISCO' : 'F'}</span></a>".html_safe
  end

  def link_to_shikiho(model, full = false)
    "<a class=#{link_class_name('shikiho', full)} href='https://shikiho.jp/stocks/#{model.code}/' target='_blank'>\
    <span>#{full ? '四季報' : '四'}</span></a>".html_safe
  end

  def link_to_getsuji(model, full = false)
    "<a class=#{link_class_name('getsuji', full)} href='http://kabuka.biz/getuji/code/#{model.code}.htm' target='_blank'>\
    <span>#{full ? '月次Web' : '月'}</span></a>".html_safe
  end

  def chrome_extention_url
    "https://chrome.google.com/webstore/detail/imarket%E3%82%B5%E3%83%BC%E3%83%81/acjlglhdafdpngebjlidbmgnlplfpgpd"
  end

  def red_hundred(num)
    return unless num

    num = (num * 100).round(1)
    num < 0 ? span_red(num) : num.to_s
  end

  def red_hundred_p(num)
    return unless num

    num = (num * 100).round(1)
    num_percent = "#{num}%"
    num < 0 ? span_red(num_percent) : num_percent
  end

  def red_delimiter(num)
    return unless num

    num_delim = number_with_delimiter(num)
    num < 0 ? span_red(num_delim) : num_delim
  end

  def red_delimiter_per_share(num)
    return unless num

    num_delim = number_with_delimiter(format("%.2f", num.to_f))
    num < 0 ? span_red(num_delim) : num_delim
  end

  def span_red(value)
    content_tag(:span, value, style: "color:#d3381c")
  end
end
