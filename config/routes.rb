Rails.application.routes.draw do
  resources :restaurants, shallow: true do
    resources :tables do
      resources :orders do
        post 'items/:id/add' => "order_items#add_quantity", as: "order_item_add"
        post 'items/:id/reduce' => "order_items#reduce_quantity", as: "order_item_reduce"
        post 'items' => "order_items#create"
        get 'items/:id' => "order_items#show", as: "order_item"
        get 'items' => "order_items#index", as: "order_items"
        delete 'items/:id' => "order_items#destroy"
        resources :payments, path: 'payment' do
          collection do
            get :client_token
            get :status
          end
        end
      end
    end
    get 'orders' => "restaurants#orders"
    resources :menu_categories do
      resources :menu_items
    end
  end
end