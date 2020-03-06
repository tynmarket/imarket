class SystemStatus < ActiveRecord::Base

  # 株価反映日時
  STOCK_PRICE_LAST_UPDATED = 1

  class << self
    def stock_price_last_updated
      system_status = find_by id: STOCK_PRICE_LAST_UPDATED

      return unless system_status

      last_updated = DateTime.parse system_status.status
      text = last_updated.strftime(Utils::Constants::YMD_HM_KA_LA)

      if stock_price_update_delayed?(last_updated)
        # 営業日の17時以降に株価が更新されていない場合、更新の遅れを表示する
        "#{text}（更新が遅れています）"
      else
        text
      end
    end

    def stock_price_update_delayed?(last_updated)
      now = Time.current
      today = Date.today
      prev_trading_day = TradingDayJp.prev(today)

      today.trading_day_jp? && last_updated < today && now.hour >= 17 ||
        !today.trading_day_jp? && prev_trading_day > last_updated.to_date
    end
  end
end
