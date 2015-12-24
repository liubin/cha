Rails.application.routes.draw do
  get 'wish/list'
  get 'wish/all'
  get 'wish/new'
  delete 'wish/:id/destroy' => 'wish#destroy', as: 'wish_destroy'
  post 'wish/:id/update' => 'wish#update', as: 'wish'
  post 'wish/create'

  resources :books do
    member do
      match 'transfer', via: ['get', 'post']
      match 'borrowing', via: ['get', 'post']
      match 'waiting', via: ['get', 'post']
    end

    collection do
      match 'isbn', via: ['get', 'post']
    end
  end

  get 'profile' => 'profile#show'
  get 'user/:id' => 'profile#show'
  get 'profile/edit'
  match 'profile/update', :via => ['post']
  match 'profile/avatar', :via => ['post', 'get']

  get 'dash/index'

  # devise_for :users
  devise_for :users, controllers: { registrations: "users/registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: "dash#index"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
