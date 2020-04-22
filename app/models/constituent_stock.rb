class ConstituentStock < ApplicationRecord
  belongs_to :revision_history
  belongs_to :stock

  delegate :code, to: :stock
end
