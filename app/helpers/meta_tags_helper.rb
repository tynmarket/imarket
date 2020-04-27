module MetaTagsHelper
  def set_title_and_description
    case controller_name
    when "eps_estimates"
      set_title_and_description_eps_estimates
    when "stock_splits"
      set_title_and_description_stock_splits
    else
      set_title_and_description_others
    end
  end

  def set_title_and_description_eps_estimates
    @title = "ダウ平均・構成銘柄予想EPS修正履歴 | iMarket（適時開示ネット）"
    @description = "ダウ平均と構成銘柄の予想EPSの修正履歴を確認することができます。"
  end

  def set_title_and_description_stock_splits
    @title = "株式分割一覧 | iMarket（適時開示ネット）"
    @description = "全銘柄と日経平均採用銘柄の株式分割の一覧を確認することができます。"
  end

  def set_title_and_description_others
    title =
      if controller_name == "favorites"
        "お気に入り | "
      elsif @stock
        "【#{@stock.code}】#{@stock.name}の決算短信 | "
      elsif @date && !current_page?(root_path)
        "#{l(@date, format: :ymd_k)}の決算短信 | "
      end
    head = @stock.name || l(@date, format: :ymd_k) || "東証"

    @title = "#{title}iMarket（適時開示ネット）"
    @description = "#{head}の適時開示で開示された決算短信や業績予想の修正の一覧が見られます。" +
      "四半期ごとの業績の推移や前年比、営業利益率、予想PERとPBRの時系列データをグラフ確認できます。"
  end
end
