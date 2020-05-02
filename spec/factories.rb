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
  end

  factory :system_status do

    trait :stock_price_last_updated do
      id { SystemStatus::STOCK_PRICE_LAST_UPDATED }
    end
  end
  end
end
