# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_05_060308) do

  create_table "authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "balance_sheets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "disclosure_id", null: false
    t.integer "stock_id", null: false
    t.string "code", limit: 6, null: false
    t.integer "year", limit: 2, null: false
    t.integer "month", limit: 1, null: false
    t.integer "quarter", limit: 1, null: false
    t.integer "interest_bearing_debt_fisco", comment: "有利子負債（FISCO）"
    t.integer "net_cash_fisco", comment: "ネットキャッシュ（FISCO）"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_balance_sheets_on_code"
    t.index ["disclosure_id"], name: "index_balance_sheets_on_disclosure_id"
    t.index ["stock_id"], name: "index_balance_sheets_on_stock_id"
  end

  create_table "cash_flows", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "disclosure_id", null: false
    t.integer "stock_id", null: false
    t.string "code", limit: 6, null: false
    t.integer "year", limit: 2, null: false
    t.integer "month", limit: 1, null: false
    t.integer "quarter", limit: 1, null: false
    t.integer "net_cash_provided_by_used_in_operating_activities"
    t.integer "net_cash_provided_by_used_in_investment_activities"
    t.integer "fcf"
    t.integer "net_cash_provided_by_used_in_financing_activities"
    t.integer "net_increase_decrease_in_cash_and_cash_equivalents"
    t.integer "cash_and_cash_equivalents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_cash_flows_on_code"
    t.index ["disclosure_id"], name: "index_cash_flows_on_disclosure_id"
    t.index ["stock_id"], name: "index_cash_flows_on_stock_id"
  end

  create_table "disclosures", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "release_date"
    t.string "code", limit: 6
    t.string "name"
    t.string "title"
    t.string "pdf"
    t.string "zip"
    t.integer "stock_id"
    t.integer "category", limit: 2, default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category", "stock_id"], name: "index_disclosures_category_stock_id"
    t.index ["code", "release_date"], name: "index_disclosures_code_release_date"
    t.index ["pdf"], name: "index_disclosures_pdf"
    t.index ["release_date", "category", "code"], name: "index_disclosures_release_date_category_code"
    t.index ["stock_id"], name: "index_disclosures_stock_id"
  end

  create_table "favorites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "stock_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_favorites_on_stock_id"
    t.index ["user_id", "stock_id"], name: "index_favorites_on_user_id_and_stock_id", unique: true
  end

  create_table "latest_results_forecasts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", limit: 6
    t.integer "year", limit: 2
    t.integer "month", limit: 1
    t.integer "quarter", limit: 1
    t.boolean "is_consolidated", default: true
    t.integer "forecast_net_sales"
    t.integer "forecast_operating_income"
    t.integer "forecast_ordinary_income"
    t.integer "forecast_net_income"
    t.float "forecast_net_income_per_share"
    t.integer "previous_forecast_net_sales"
    t.integer "previous_forecast_operating_income"
    t.integer "previous_forecast_ordinary_income"
    t.integer "previous_forecast_net_income"
    t.float "previous_forecast_net_income_per_share"
    t.float "change_in_forecast_net_sales"
    t.float "change_in_forecast_operating_income"
    t.float "change_in_forecast_ordinary_income"
    t.float "change_in_forecast_net_income"
    t.float "change_forecast_net_sales"
    t.float "change_forecast_operating_income"
    t.float "change_forecast_ordinary_income"
    t.float "change_forecast_net_income"
    t.integer "disclosure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_latest_results_forecasts_code"
  end

  create_table "price_intradays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", null: false
    t.integer "period", limit: 2, null: false
    t.datetime "datetime", null: false
    t.datetime "datetime_original", null: false
    t.integer "day", limit: 1, null: false, comment: "1-7、月曜は1"
    t.integer "hour", limit: 1, null: false
    t.integer "minute", limit: 1, null: false
    t.float "open", null: false
    t.float "high", null: false
    t.float "low", null: false
    t.float "close", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "datetime", "close"], name: "index_prices_intradays_code_datetime_close", unique: true
  end

  create_table "results_forecasts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", limit: 6
    t.integer "year", limit: 2
    t.integer "month", limit: 1
    t.integer "quarter", limit: 1
    t.boolean "is_consolidated", default: true
    t.integer "forecast_net_sales"
    t.integer "forecast_operating_income"
    t.integer "forecast_ordinary_income"
    t.integer "forecast_net_income"
    t.float "forecast_net_income_per_share"
    t.integer "previous_forecast_net_sales"
    t.integer "previous_forecast_operating_income"
    t.integer "previous_forecast_ordinary_income"
    t.integer "previous_forecast_net_income"
    t.float "previous_forecast_net_income_per_share"
    t.float "change_in_forecast_net_sales"
    t.float "change_in_forecast_operating_income"
    t.float "change_in_forecast_ordinary_income"
    t.float "change_in_forecast_net_income"
    t.float "change_forecast_net_sales"
    t.float "change_forecast_operating_income"
    t.float "change_forecast_ordinary_income"
    t.float "change_forecast_net_income"
    t.integer "disclosure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["disclosure_id", "quarter"], name: "index_unique_results_forecasts_disclosure_id_quarter", unique: true
    t.index ["quarter", "code"], name: "index_results_forecasts_quarter_code"
  end

  create_table "stock_prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", limit: 6
    t.integer "term", limit: 1
    t.date "date"
    t.float "open"
    t.float "high"
    t.float "low"
    t.float "close"
    t.integer "volume"
    t.integer "value"
    t.float "change"
    t.float "change_rate"
    t.integer "market_cap"
    t.bigint "shares"
    t.float "per"
    t.float "pbr"
    t.float "market_cap_fcf_ratio"
    t.float "ytd"
    t.float "close_adjusted"
    t.integer "stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["term", "code", "date", "close"], name: "index_stock_prices_term_code_date_close"
    t.index ["term", "code", "date", "per"], name: "index_stock_prices_term_code_date_per"
    t.index ["term", "stock_id"], name: "index_stock_prices_term_stock_id"
  end

  create_table "stock_splits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", limit: 6
    t.date "allocation_date"
    t.date "split_date"
    t.float "split_ratio"
    t.date "effect_date"
    t.integer "stock_id"
    t.integer "disclosure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code", "disclosure_id"], name: "index_stock_splits_code_disclosure_id"
    t.index ["disclosure_id", "split_date"], name: "index_stock_splits_disclosure_id_split_date"
  end

  create_table "stocks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", limit: 6
    t.string "name"
    t.string "search_name"
    t.date "listed_date"
    t.boolean "is_consolidated", default: true
    t.string "taisyaku_code", limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_stocks_code"
  end

  create_table "summaries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "code", limit: 6
    t.integer "year", limit: 2
    t.integer "month", limit: 1
    t.integer "quarter", limit: 1
    t.boolean "is_consolidated", default: true
    t.integer "net_sales"
    t.integer "operating_income"
    t.integer "ordinary_income"
    t.integer "net_income"
    t.float "net_income_per_share"
    t.float "change_in_net_sales"
    t.float "change_in_operating_income"
    t.float "change_in_ordinary_income"
    t.float "change_in_net_income"
    t.integer "prior_net_sales"
    t.integer "prior_operating_income"
    t.integer "prior_ordinary_income"
    t.integer "prior_net_income"
    t.float "prior_net_income_per_share"
    t.float "change_in_prior_net_sales"
    t.float "change_in_prior_operating_income"
    t.float "change_in_prior_ordinary_income"
    t.float "change_in_prior_net_income"
    t.integer "disclosure_id"
    t.integer "owners_equity"
    t.bigint "number_of_shares"
    t.integer "number_of_treasury_stock", unsigned: true
    t.float "net_assets_per_share"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_summaries_code"
    t.index ["disclosure_id"], name: "index_summaries_disclosure_id"
  end

  create_table "system_statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

end
