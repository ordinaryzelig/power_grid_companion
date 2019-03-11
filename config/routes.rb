Rails.application.routes.draw do

  resources :games, :only => [:create]
  resources :players, :only => [] do
    member do
      post :claim
    end
  end
  resources :auctions, :only => [:create] do
    member do
      post :bid
      post :pass
    end
  end
  resources :buildings, :only => [:create]
  resources :resource_purchases, :only => [:create]

end
