module DisclosureCategory
  extend ActiveSupport::Concern

  # 月次
  MONTHLY = 1

  included do
    scope :monthly, -> { where(category: MONTHLY) } if respond_to? :scope
  end

  def monthly?
    category == MONTHLY
  end

end
