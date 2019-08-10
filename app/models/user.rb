class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :favorites

  accepts_nested_attributes_for :authentications

  def favorite(stock_id)
    favorites.find_by!(stock_id: stock_id)
  end
end
