module FinancialInformation
  extend ActiveSupport::Concern

  included do
    scope :accounting_period_desc, -> { order(year: :desc, month: :desc, quarter: :desc) } if respond_to? :scope

    belongs_to :disclosure_pdf, -> { select :id, :release_date, :pdf },
      class_name: "Disclosure", foreign_key: "disclosure_id" if respond_to? :belongs_to
    # :idがないとincludes出来ない。
    # Summaryでselect指定する場合は:diclosure_idが必要 TODO Rails 3.2で検証
  end

  def accounting_period
    "#{year}/#{month_padding(month)}"
  end

  def accounting_period_long
    "#{year}/#{month_padding(month)} #{quarter_name}"
  end

  def prev_accounting_period
    "#{year - 1}/#{month_padding(month)}"
  end

  def prev_accounting_period_long
    "#{year - 1}/#{month_padding(month)} #{quarter_name}"
  end

  # 各年度の最新の四半期のみ表示
  def accounting_period_once(next_information)
    return unless year

    if !next_information || year != next_information.year ||
        (year == next_information.year && month != next_information.month)
      "#{year}/#{month_padding(month)}"
    end
  end

  def quarter_name
    "#{quarter}Q"
  end

  def month_padding(month)
    sprintf("%02d", month)
  end

  def q4?
    quarter == 4
  end
end