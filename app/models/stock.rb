class Stock < ActiveRecord::Base
  has_many :favorites

  MOJI_DELETE = /株式会社|（株）|・/ # 「株式会社」（株）・を削除
  SPACE = / |　/ # 半角・全角空白

  CODE_ALL_STOCK_MEDIAN = "10000" # 全銘柄（中央値）
  CODE_INDEX = ["998407"] # 日経平均

  has_many :disclosures

  has_many :disclosures_monthly, -> { select(:id, :stock_id, :release_date, :title, :pdf).monthly },
           class_name: "Disclosure"

  has_one :stock_price_latest, -> { where term: StockPrice::LATEST }, class_name: "StockPrice"

  has_many :shikihos

  class << self
    def code_dow
      "^DJI"
    end

    def code_n225
      "998407"
    end

    def code_n225_r
      "998407-r"
    end

    # utf8_bin:ガスミ…なし
    #         :７２０３…なし
    #         :TOYOTA…なし
    #         :ＴＯＹＯＴＡ…なし
    # utf8_general_ci:ガスミ…なし
    #                :７２０３…なし
    #                :TOYOTA…あり
    #                :ＴＯＹＯＴＡ…なし
    # デフォルト:全てあり
    #
    def search(param)
      return none if param.blank?

      id = param.tr("０-９", "0-9").to_i

      if id != 0 # 証券コード（=id）
        where id: id
      else # キーワード
        search_from_keyword(param)
      end
    end

    def search_from_keyword(keyword)
      search_names = keyword
                     .split(SPACE)
                     .reject(&:blank?)
                     .map { |name| to_search_name name } # 検索名

      statement = (["search_name"] * search_names.length).join(" LIKE ? AND ") + " LIKE ?"
      values = search_names.map { |search_name| "%#{search_name}%" }

      where(statement.to_s, *values)
    end

    def filter_index(code, user)
      user.admin? || index?(code) ? code : nil
    end

    def index?(code)
      CODE_INDEX.include? code
    end

    private

    def to_search_name(name)
      return unless name

      hankaku_downcase(katakana(delete_kabu(name)))
    end

    def hankaku_downcase(name)
      name.tr("ａ-ｚ", "a-z").tr("Ａ-Ｚ", "a-z").tr("０-９", "0-9").tr("＆", "&") # 半角英数字小文字
    end

    def katakana(name)
      name.tr "ぁ-ん", "ァ-ン" # 全角カタカナ
    end

    def delete_kabu(name)
      name.gsub(MOJI_DELETE, "")
    end
  end

  def for_disclosures_monthly
    disclosures_monthly.sort_by { |d| d.id * -1 }
  end

  def shikiho_latest
    shikihos.last
  end

  def per
    stock_price_latest.try(:per)
  end

  def pbr
    stock_price_latest.try(:pbr)
  end

  def fcf_ratio
    ratio = stock_price_latest&.fcf_ratio
    "#{ratio} 倍" if ratio
  end

  def change_rate
    stock_price_latest&.change_rate
  end

  def ytd
    stock_price_latest&.ytd
  end

  def all_stock_median?
    code == CODE_ALL_STOCK_MEDIAN
  end
end
