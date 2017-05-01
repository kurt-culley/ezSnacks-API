Rails.application.routes.draw do

  resources :restaurants
  resources :tables

  resources :orders do
    resources :payments
  end

  resources :menu_categories do
    resources :menu_items
  end

end
