class SystemStatus < ActiveRecord::Base

  # 株価反映日時
  STOCK_PRICE_LAST_UPDATED = 1

  def self.stock_price_last_updated(format = true)
    system_status = find_by id: STOCK_PRICE_LAST_UPDATED

    if system_status
      last_updated = DateTime.parse system_status.status
      format ? last_updated.strftime(Utils::Constants::YMD_HM_KA_LA) : last_updated
    end
  end

end
