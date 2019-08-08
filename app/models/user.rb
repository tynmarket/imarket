class User < ApplicationRecord
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  authenticates_with_sorcery!
end
