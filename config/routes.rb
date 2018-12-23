Rails.application.routes.draw do
  root 'disclosures#index'

  # 開示情報
  get 'disclosures/:date', to: 'disclosures#index', as: 'disclosures'

  # 銘柄
  resources 'stocks', only: [:show] do
    get 'search', on: :collection
  end

  # 株価
  resources 'stock_prices', only: [] do
    member do
      get 'per'
      get 'pbr'
    end
  end

  # API
  namespace :api, defaults: { format: :json } do
    resources :stock_prices, param: :code, only: [:show]
  end
end
