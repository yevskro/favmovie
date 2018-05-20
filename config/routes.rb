Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [ :show, :index, :update ] do
    resources :movies, only: [ :index ]
  end
  delete "/users/:id", to: "users#destroy", as: "destroy_user"

  resources :username, only: [ :new, :create ]

  get "movies/search", to: "movies#search"
  resources :movies, except: [ :destroy ] do
    resources :directors, only: [ :new, :create ]
    resources :screenwriters, only: [ :new, :create ]
    resources :actors, only: [ :new, :create ]
  end
  get "movies/find_top_rating/:take", to: "movies#find_top_rating", as: "movie_top_rating"

  delete "/movies/:id", to: "movies#destroy", as: "destroy_movie"

  resources :directors, only: [ :new, :create ]
  delete "/directors/:id", to: "directors#destroy", as: "destroy_director"

  resources :screenwriters, only: [ :new, :create ]
  delete "/screenwriters/:id", to: "screenwriters#destroy", as: "destroy_screenwriter"

  resources :actors, only: [ :new, :create ]
  delete "/actors/:id", to: "actors#destroy", as: "destroy_actor"

  root to: "movies#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  ## custom routes for users
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
