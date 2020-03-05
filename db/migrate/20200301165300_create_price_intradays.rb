class CreatePriceIntradays < ActiveRecord::Migration[5.2]
  def change
    create_table :price_intradays do |t|
      t.integer :stock_id # 必須にするか未定
      t.string :code, null: false
      t.integer :period, limit: 2, null: false, comment: "分足"
      t.datetime :datetime, null: false, comment: "日時"
      t.datetime :datetime_local, null: false, comment: "日時（現地）"
      t.integer :day, limit: 1, null: false, comment: "0-6、日曜は0（MySQLのDAYOFWEEKは日曜日が1）"
      t.integer :session, limit: 2, comment: "0 - 日中, 1 - ナイトセッション"
      t.integer :hour, limit: 1, null: false
      t.integer :minute, limit: 1, null: false
      t.float :open, null: false
      t.float :high, null: false
      t.float :low, null: false
      t.float :close, null: false
      t.integer :volume

      t.timestamps

      t.index [:code, :period, :datetime], unique: true, name: "index_prices_intradays_code_period_datetime"
    end
  end
end
