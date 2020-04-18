class EpsEstimate < ApplicationRecord
  scope :dow, -> { where(code: "^DJI") }
end
