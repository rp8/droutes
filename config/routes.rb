Droutes::Application.routes.draw do

  devise_for :users, :path_names => {:sign_up => 'register'}

  match '/admin' => 'admin#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # admin
  match 'users/:id', :to => 'admin#show'
  match 'users/:id/orders', :to => 'admin#list_orders'
  match 'users/:id/customers', :to => 'admin#list_customers'

  match 'profile', :to => 'profile#show', :via => 'get'
  match 'profile/edit', :to => 'profile#edit', :via => 'get'
  match 'profile/update', :to => 'profile#update', :via => 'put'

  resources :users

  match 'customers/map_all', :to => 'customers#map_all'
  match 'customers/duplicated', :to => 'customers#duplicated'
  match 'customer/map', :to => 'customers#map'

  resources :customers do
  end

  resources :orders do
    put :toggle
    get :direction
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => "orders#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
