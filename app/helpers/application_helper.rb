module ApplicationHelper
  include Utils::Constants
  include Utils::UtilMethod

  def set_title_and_description
    title =
      if controller_name == "favorites"
        "お気に入り | "
      elsif @stock
        "【#{@stock.code}】#{@stock.name}の決算短信 | "
      elsif @date && !current_page?(root_path)
        "#{l(@date, format: :ymd_k)}の決算短信 | "
      end

    @title = "#{title}iMarket（適時開示ネット）"
    @description = "#{title || '東証'}の適時開示で開示された決算短信や業績予想の修正の一覧が見られます。四半期ごとの業績の推移や前年比、営業利益率、予想PERとPBRの時系列データをグラフ確認できます。"
  end

  def body_class
    "#{controller_name} #{'logged_in' if logged_in?}"
  end

  def google?
    return false unless current_user

    current_user.authentications.first.provider == "google"
  end

  def release_notes
    <<~EOS.html_safe
      （8/19）逆日歩のリンク先を <a href="https://www.nisshokin.com/" target='_blank'>日証金.COM</a> に変更しました<br>
      （8/17）お気に入りのログインに <a href="/login">Twitterログイン</a> を追加しました
    EOS
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

  def link_to_other_services(model, full = false)
    link_to_other_services_short(model, full) + link_to_taiho(model, full) +
      link_to_karauri(model, full) + link_to_balance(model, full) + link_to_pcsl(model, full) +
      link_to_yuho(model, full) + link_to_pts(model, full) + link_to_sbi(model, full) +
      link_to_kabutan(model, full)
  end

  def link_to_other_services_short(model, full = false)
    link_to_chart(model, full) + link_to_profile(model, full) +
      link_to_margin(model, full) + link_to_ifis(model, full)
  end

  def link_class_name(class_name, full = false)
    "link-#{class_name} #{'full-service-name' if full}"
  end

  def link_to_chart(model, full = false)
    "<a class=#{link_class_name('chart', full)} href='http://stocks.finance.yahoo.co.jp/stocks/chart/?code=#{model.code}' target='_blank'>\
    <span class='glyphicon glyphicon-signal'></span>#{'チャート' if full}</a>".html_safe
  end

  def link_to_profile(model, full = false)
    "<a class=#{link_class_name('profile', full)} href='http://stocks.finance.yahoo.co.jp/stocks/profile/?code=#{model.code}' target='_blank'>\
    <span>#{full ? '企業情報' : '企'}</span></a>".html_safe
  end

  def link_to_margin(model, full = false)
    to = Date.today
    from = to.last_year.next_week

    ("<a class=#{link_class_name('margin', full)}" +
      " href='http://info.finance.yahoo.co.jp/history/margin/?code=#{model.code}&sy=#{from.year}&sm=#{from.month}&sd=#{from.day}" +
      "&ey=#{to.year}&em=#{to.month}&ed=#{to.day}' target='_blank'><span>#{full ? '信用残' : '信'}</span></a>").html_safe
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

  def red_hundred(num)
    return unless num

    num = (num * 100).round(1)
    num < 0 ? span_red(num) : num.to_s
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
