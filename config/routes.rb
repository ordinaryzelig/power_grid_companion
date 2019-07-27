Rails.application.routes.draw do

  resources :games, :only => %i[new create show] do
    member do
      get :join
    end
    resources :cards, :only => %i[index]
  end
  resources :players, :only => [] do
    member do
      post :claim
      get :claim if Rails.env.development?
    end
  end
  resources :turn_orders, :only => %i[new create]
  resources :auctions, :only => %i[new create show] do
    member do
      post :bid
      post :pass
      post :claim
    end
    collection do
      post :skip
    end
  end
  resources :buildings, :only => %i[new create] do
    collection do
      post :pass
    end
  end
  resources :resource_purchases, :only => %i[new create] do
    collection do
      post :pass
    end
  end
  resources :cities_power_ups, :only => %i[new create index] do
    collection do
      post :pass
    end
  end
  resources :resource_replenishments, :only => %i[new create]
  resources :market_bureaucracies, :only => %i[new create index]
  resources :step3s, :only => %i[index create]
  resources :resource_transfers, :only => %i[new create]

end
