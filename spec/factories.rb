FactoryBot.define do
  factory :disclosure do
    code { "1111" }
    stock

    trait :monthly do
      category { Disclosure::MONTHLY }
    end
  end

  factory :summary do
    code { "1111" }
  end

  factory :results_forecast do
    code { "1111" }
  end

  factory :latest_forecast, class: LatestResultsForecast do
    code { "1111" }
    quarter { 4 }
  end

  factory :stock do
    code { "1111" }
    name { "銘柄1" }
  end

  factory :stock_price do
    code { "1111" }
    stock

    trait :latest do
      term { :latest }
    end

    trait :daily do
      term { :daily }
    end

    trait :n225 do
      code { Stock.code_n225 }
    end

    trait :dow do
      code { Stock.code_dow }
    end
  end

  factory :system_status do

    trait :stock_price_last_updated do
      id { SystemStatus::STOCK_PRICE_LAST_UPDATED }
    end
  end

  factory :eps_estimate do
    current_quarter { "1900-01-01" }
    next_quarter { "1900-01-01" }
    current_year { "1900-01-01" }
    next_year { "1900-01-01" }
    current_quarter_eps { 0 }
    next_quarter_eps { 0 }
    current_year_eps { 0 }
    next_year_eps { 0 }

    trait :n225 do
      code { Stock.code_n225 }
    end

    trait :n225_r do
      code { Stock.code_n225_r }
    end

    trait :dow do
      code { Stock.code_dow }
    end
  end
end
