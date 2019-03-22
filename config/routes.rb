Rails.application.routes.draw do

  resources :games, :only => %i[new create show]
  resources :players, :only => [] do
    member do
      post :claim
      get :claim if Rails.env.development?
    end
  end
  resources :auctions, :only => %i[new create show] do
    member do
      post :bid
      post :pass
      post :claim
    end
  end
  resources :buildings, :only => %i[create]
  resources :resource_purchases, :only => %i[create]
  resources :cities_power_ups, :only => %i[create]
  resources :resource_replenishments, :only => %i[create]

end
