Rails.application.routes.draw do
  devise_for :users

  as :user do
    get "/masuk" => "devise/sessions#new"
  end

  resources :blogs do
    member do
      post 'do_crawling'
      post 'do_indexing'
      delete 'drop_indexing'
    end

    resources :links do
      member do
        post 'update_whitelist'
        post 'update_blacklist'
      end
    end
  end

  resources :articles do
    collection { get :search }
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'dashboard' => 'dashboard#index'
  post 'reindex' => 'dashboard#reindex'
  post 'recreate_sitemap' => 'dashboard#recreate_sitemap'
  post 'refresh_sitemap' => 'dashboard#refresh_sitemap'
  get 'search' => 'home#search'
  get 'preview' => 'preview#preview'
  get 'domain/:id' => 'blogs#show'
  get ':id' => 'articles#show'
  get '*path/:id' => 'articles#show'
  get '*path/*path/:id' => 'articles#show'

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
