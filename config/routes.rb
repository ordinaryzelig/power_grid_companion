Rails.application.routes.draw do

  resources :players, :only => [] do
    member do
      post :claim
    end
  end
  resources :auctions, :only => [:create]
  resources :resource_purchases, :only => [:create]

end
