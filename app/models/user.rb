class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :authentications

  def favorite(stock_id)
    favorites.find_by(stock_id: stock_id)
  end

  def favorite_exist?(stock_id)
    favorites.find_by(stock_id: stock_id)
  end

  def add_favorite(stock_id)
    Favorite.create(stock_id: stock_id, user_id: id) rescue nil # 作成済みなど
  end

  def favorite_code_hash
    favorites.joins(:stock).pluck("stocks.code").map { |code| [code, true] }.to_h
  end
end
