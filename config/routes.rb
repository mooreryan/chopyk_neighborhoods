Rails.application.routes.draw do
  get 'apple_pie/peanuts'

  get 'interactions/new'

  get 'arrangement/new'

  get 'arrangement_dists/new'

  get 'collapses/new'

  resources :collapses
  # resources :interactions

  root 'static_pages#home'

  # this also gives named routes like help_path
  match '/help',      to: 'static_pages#help',       via: :get
  match '/about',     to: 'static_pages#about',      via: :get
  match '/contact',   to: 'static_pages#contact',    via: :get
  # need the post for the form submit button
  match '/search',    to: 'neighborhoods#search',    via: [:get, :post]
  match '/upload',    to: 'neighborhoods#upload',    via: :get
  match '/neighbors', to: 'neighborhoods#neighbors', via: [:get, :post]
  match( '/superfamilies', to: 'neighborhoods#superfamilies', 
         via: [:get, :post] )
  match '/contigs',   to: 'neighborhoods#contigs',   via: [:get, :post]
  match '/sfcontigs',   to: 'neighborhoods#sfcontigs',   via: [:get, :post]
  match '/download_sfcontigs',   to: 'neighborhoods#download_sfcontigs',   via: [:get, :post]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
