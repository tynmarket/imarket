class SystemStatus < ActiveRecord::Base

  # 株価反映日時
  STOCK_PRICE_LAST_UPDATED = 1

  def self.stock_price_last_updated
    system_status = find_by id: STOCK_PRICE_LAST_UPDATED

    return unless system_status

    last_updated = DateTime.parse system_status.status
    last_updated.strftime(Utils::Constants::YMD_HM_KA_LA)
  end

end
