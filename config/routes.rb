Rails.application.routes.draw do
  root "disclosures#index"

  # 認証
  get "login", to: "sessions#new"
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
    resource :favorite, only: [:show, :create, :destroy]
  end

  # お気に入り
  resources :favorites, only: [:index]

  # 予想EPS修正履歴
  resources :eps_estimates, only: [:index], param: :code do
    # 検索
    get "chart", on: :member, to: 'eps_estimates_charts#show', defaults: {format: :json}
  end

  # 株式分割
  resources :stock_splits, only: [:index]

  # 過去最高益銘柄
  resources :highest_forecasts, only: [:index]

  # 株価
  resources :stock_prices, only: [] do
    member do
      get "per"
      get "pbr"
      get "fcf-ratio"
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
