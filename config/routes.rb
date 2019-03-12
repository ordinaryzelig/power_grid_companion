Rails.application.routes.draw do

  resources :games, :only => [:create, :show]
  resources :players, :only => [] do
    member do
      post :claim
    end
  end
  resources :auctions, :only => [:create] do
    member do
      post :bid
      post :pass
      post :claim
    end
  end
  resources :buildings, :only => [:create]
  resources :resource_purchases, :only => [:create]
  resources :cities_power_ups, :only => [:create]
  resources :resource_replenishments, :only => [:create]

end
