Pollster::Application.routes.draw do

	match "/events/:event_id/poll/:id/graph" => "polls#graph", :as => :poll_graph
	match "/events/:event_id/vote" => "responses#vote", :as => :vote
	match "/events/:event_id/button" => "responses#button", :as => :button
  match "/events/:id/start" => "events#start"
  match "/events/:id/graph" => "events#graph", :as => :graph
  match "/events/:id/reset_options" => "events#reset_options"
	match '/' => 'responses#button', :constraints => { :subdomain => /.+/ }  
  resources :events do
    resources :polls
		
  end

  resources :users
  
  match "session/new" => "sessions#create", :via => :post
  match "session/create" => "sessions#create", :via => :post, :as => :create_session
  match "session/destroy" => "sessions#destroy", :via => :delete, :as => :destroy_session

	match "/" => "sessions#new", :as => :new_session

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
