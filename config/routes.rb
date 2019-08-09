Rails.application.routes.draw do
  root "disclosures#index"

  # 認証
  post "logout", to: "sessions#destroy"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # 開示情報
  get "disclosures/:date", to: "disclosures#index", as: "disclosures"

  # 銘柄
  resources :stocks, only: [:show] do
    # 検索
    get "search", on: :collection

    # お気に入り
    resources :favorites, only: [:create], shallow: true, module: :stocks
  end

  # お気に入り
  resources :favorites, only: [:index, :destroy]

  # 株価
  resources :stock_prices, only: [] do
    member do
      get "per"
      get "pbr"
    end
  end


  # PDF（iMrket以外）
  get "pdf/*path", to: "pdfs#show"

  # API
  namespace :api, defaults: { format: :json } do
    resources :stock_prices, param: :code, only: [:show]
    resource :announce, only: [] do
      member do
        get "financial_results"
        get "forecast"
      end
    end
  end
end
