Rails.application.routes.draw do

  resources :restaurants do
    resources :tables

    resources :menu_categories do
      resources :menu_items
    end

    resources :orders do
      resources :payments
    end
  end

end
