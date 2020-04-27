class RevisionHistory < ApplicationRecord
  has_many :constituent_stocks
  has_many :stocks, through: :constituent_stocks
end
