Wanerbu::Application.routes.draw do


  get "attribute_reports/index"

  # 普通用户认证部分
  devise_for :users, :path => 'auth',
             :path_names => { :sign_in => 'login', :sign_out => 'logout'}

  # 系统管理员认证部分
  devise_for :admins, :controllers => {:sessions => 'admin/admins/sessions'},
             :path => 'admin/auth', :path_names => { :sign_in => 'login', :sign_out => 'logout'}

  # 默认主页
  root :to => 'welcome#index'

  # 系统管理员route
  namespace :admin do
    root :to => 'dashboard#index'
    get 'dashboard' => 'dashboard#index'
    namespace :master do
      resources :admins, :except => [:index]
      resources :admin_reports, :only => [:index]
      resources :attributes, :except => [:index]
      resources :attribute_reports, :only => [:index]
    end
  end

  # 普通用户route
  namespace :user do
    root :to => 'dashboard#index'
    get 'dashboard' => 'dashboard#index'
    namespace :master do
      resources :gyms
    end
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
