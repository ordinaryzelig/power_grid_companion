Rails.application.routes.draw do

  resources :games, :only => %i[new create show]
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
  resources :cities_power_ups, :only => %i[new create]
  resources :resource_replenishments, :only => %i[new create]

end
