Rails.application.routes.draw do

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
  resources :resource_purchases, :only => [:create]

end
