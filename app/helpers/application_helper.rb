module ApplicationHelper
  include Utils::Constants
  include Utils::UtilMethod

  def release_notes
    <<~EOS.html_safe
      （4/21）サイトのURLを https://tyn-imarket.com に変更しました（https化）
      <br>
      （3/16）個別銘柄のページで1年分の開示を確認できるようにしました
      <br>
    EOS
  end

  def release_date_s(disclosure)
    disclosure.release_date.strftime YMD_S
  end

  def link_to_pdf(disclosure, text)
    if disclosure && disclosure.release_date && disclosure.pdf
      "<a href='#{disclosure.pdf_path}' target='_blank'>#{text}</a>".html_safe
    elsif text
      text.html_safe
    end
  end

  def link_to_stock(model)
    "<a href='/stocks/#{model.code}' target='_blank'>#{model.code}</a>".html_safe
  end

  def link_to_other_services(model, full = false)
    link_to_other_services_short(model, full) + link_to_taiho(model, full) +link_to_karauri(model, full) +
    link_to_balance(model, full) + link_to_pcsl(model, full) + link_to_yuho(model, full) + link_to_pts(model, full)
  end

  def link_to_other_services_short(model, full = false)
    link_to_chart(model, full) + link_to_profile(model, full) +
      link_to_margin(model, full) + link_to_ifis(model, full)
  end

  def link_to_chart(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://stocks.finance.yahoo.co.jp/stocks/chart/?code=#{model.code}' target='_blank'>\
    <span class='glyphicon glyphicon-signal'></span>#{'チャート' if full}</a>".html_safe
  end

  def link_to_profile(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://stocks.finance.yahoo.co.jp/stocks/profile/?code=#{model.code}' target='_blank'>\
    <span>#{full ? '企業情報' : '企'}</span></a>".html_safe
  end

  def link_to_margin(model, full = false)
    to = Date.today
    from = to.last_year.next_week

    ("<a #{'class="full-service-name-margin"' if full}" +
      " href='http://info.finance.yahoo.co.jp/history/margin/?code=#{model.code}&sy=#{from.year}&sm=#{from.month}&sd=#{from.day}" +
      "&ey=#{to.year}&em=#{to.month}&ed=#{to.day}' target='_blank'><span>#{full ? '信用残' : '信'}</span></a>").html_safe
  end

  def link_to_ifis(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://kabuyoho.ifis.co.jp/index.php?action=tp1&sa=report_chg&bcode=#{model.code}' target='_blank'>\
    <span>#{full ? 'コンセンサス' : 'コ'}</span></a>".html_safe
  end

  def link_to_taiho(model, full = false)
    "<a #{'class="full-service-name"' if full} href='https://maonline.jp/pro/shareholding_reports?query%5Bisname_or_issyokencode_or_company_iscode_start%5D=#{model.code}' target='_blank'>\
    <span>#{full ? '大量保有' : '大'}</span></a>".html_safe
  end

  def link_to_karauri(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://karauri.net/#{model.code}/' target='_blank'>\
    <span>#{full ? '空売り' : '空'}</span></a>".html_safe
  end

  def link_to_balance(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://www.jsf.co.jp/de/stock/data.php?target=balance&div=%93%8C%8F%D8&code=#{model.code}' target='_blank'>\
    <span>#{full ? '融資・貸株' : '融'}</span></a>".html_safe
  end

  def link_to_pcsl(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://www.jsf.co.jp/de/stock/data.php?target=pcsl&div=%93%8C%8F%D8&code=#{model.code}' target='_blank'>\
    <span>#{full ? '逆日歩' : '逆'}</span></a>".html_safe
  end

  def link_to_yuho(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://www.kabupro.jp/yuho/#{model.code}.htm' target='_blank'>\
    <span>#{full ? '有報' : '有'}</span></a>".html_safe
  end

  def link_to_pts(model, full = false)
    "<a #{'class="full-service-name"' if full} href='http://www.morningstar.co.jp/StockInfo/pts/info/#{model.code}' target='_blank'>\
    <span>#{full ? 'PTS' : 'P'}</span></a>".html_safe
  end

  def stock_path(model)
    "/stocks/#{model.code}"
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

    num_delim = number_with_delimiter(sprintf("%.2f", num.to_f))
    num < 0 ? span_red(num_delim) : num_delim
  end

  def span_red(value)
    content_tag(:span, value, style: 'color:#d3381c')
  end

end
