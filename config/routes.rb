Rails.application.routes.draw do

  resources :resource_purchases, :only => [:create]

end
