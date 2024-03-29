Housekeeping4::Application.routes.draw do
  devise_for :users,
             :path => "/app/users",
             :controllers => { :sessions => "app/sessions" },
             :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  root :to => "app/dashboard#index"

  namespace :app do
    root :to => "dashboard#index"
    match "dashboard", :to => "dashboard#index"
    resources :transactions do
      member do
        get :remote_edit
        put :remote_update
      end
    end
    #resources :statistics
    #resources :reports
    resources :categories
    resources :accounts
    #resources :settings
    resources :accounts do
      resources :transactions do
        collection do
          match 'delete(/:id)', :to => 'transactions#destroy', :via => [:post, :delete], :as => :delete
        end
      end
      collection do
        match "delete(/:id)", :to => "accounts#destroy", :via => [:post, :delete], :as => :delete
      end
    end
    # URL for 'all' account
    match "accounts/:account_id/transactions", :to => "transactions#index", :account_id => 0, :as => :accounts_transactions
  end

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

