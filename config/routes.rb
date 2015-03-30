Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  as :user do
    post '/user/sign_up', to: 'registrations#create'
  end

  # User routes
  get '/user', to: 'users#show'

  # Picture routes
  get '/picture/all', to: 'pictures#index'
  get '/picture', to: 'pictures#show'
  post '/picture/create', to: 'pictures#create'
  put '/picture/update', to: 'pictures#update'
  delete '/picture/delete', to: 'pictures#delete'

  # Video routes
  get '/video/all', to: 'videos#index'
  get '/video', to: 'videos#show'
  post '/video/create', to: 'videos#create'
  put '/video/update', to: 'videos#update'
  delete '/video/delete', to: 'videos#delete'

  # Award routes
  get '/award/all', to: 'awards#index'
  get '/award', to: 'awards#show'
  post '/award/create', to: 'awards#create'
  put '/award/update', to: 'awards#update'
  delete '/award/delete', to: 'awards#delete'

  # Blog routes
  get '/blog/all', to: 'blogs#index'
  get '/blog', to: 'blogs#show'
  post '/blog/create', to: 'blogs#create'
  put '/blog/update', to: 'blogs#update'
  delete '/blog/delete', to: 'blogs#delete'

  # Distributor routes
  get '/distributor/all', to: 'distributors#index'
  get '/distributor', to: 'distributors#show'
  post '/distributor/create', to: 'distributors#create'
  put '/distributor/update', to: 'distributors#update'
  delete '/distributor/delete', to: 'distributors#delete'

  # Challenge routes
  get '/challenge/all', to: 'challenges#index'
  get '/challenge', to: 'challenges#show'
  post '/challenge/create', to: 'challenges#create'
  put '/challenge/update', to: 'challenges#update'
  delete '/challenge/delete', to: 'challenges#delete'

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
