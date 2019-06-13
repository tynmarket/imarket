class Stock < ActiveRecord::Base

  MOJI_DELETE = /株式会社|（株）|・/ # 「株式会社」（株）・を削除
  SPACE = / |　/ # 半角・全角空白

  CODE_INDEX = ["998407"] # 日経平均

  has_many :disclosures

  has_many :disclosures_monthly, -> { select(:id, :stock_id, :release_date, :title, :pdf).monthly }, class_name: "Disclosure"

  has_one :stock_price_latest, -> { where term: StockPrice::LATEST }, class_name: "StockPrice"

  has_many :shikihos

  class << self

    #
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
        search_names = param
                       .split(SPACE)
                       .reject(&:blank?)
                       .map{ |name| to_search_name name } # 検索名

        statement = (["search_name"] * search_names.length).join(" LIKE ? AND ") + " LIKE ?"
        values = search_names.map { |search_name| "%#{search_name}%" }

        where(statement.to_s, *values)
      end
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

  def shikiho_latest
    shikihos.last
  end

  def per
    stock_price_latest.try(:per)
  end

  def pbr
    stock_price_latest.try(:pbr)
  end

end
