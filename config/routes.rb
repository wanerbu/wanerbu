Wanerbu::Application.routes.draw do


  mount Rich::Engine => '/rich', :as => 'rich'

  # 前台部分
  #
  # 场馆相关
  get "gym/gym_home"
  match 'gym/search/:sportid/:areaid/:keyword/:reservekey/:sortkey' => 'gym#search',:via=>:get
  match 'gym/one_gym/:id/:sportid' => 'gym#one_gym',:via=>:get
  match 'gym/submit_comment' => 'gym#submit_comment',:via => :post
  match 'gym/search_comment/:gymid' => 'gym#search_comment',:via=>:get
  match 'gym/delete_comment/:gymid/:commentid' => 'gym#delete_comment',:via=>:get
  match 'gym/check_comment_time' => 'gym#check_comment_time',:via => :post
  match 'gym/getcourt/:gymid/:sportid/:reservationtype' => 'gym#getcourt',:via=>:get
  match 'gym/reserve/:id/:date' => 'gym#reserve',:via=>:get
  match 'gym/searchgame/:id/:date' => 'gym#searchgame',:via=>:get
  match 'gym/check_order' => 'gym#check_order',:via => :post
  match 'gym/check_code_image/:type_code' => 'gym#check_code_image',:via => :get
  match 'gym/submit_order' => 'gym#submit_order',:via => :post
  match 'gym/search_map' => 'gym#search_map',:via => :post
  match 'gym/code_image' => 'gym#code_image',:via => :get

  # 活动相关
  get "activities/activity_home"
  resources :activities, :except => [:index] 
  # 普通用户认证部分
  devise_for :users,
             :controllers => {:sessions => 'user/users/sessions', :registrations => 'user/users/registrations'},
             :path => 'auth',
             :path_names => { :sign_in => 'login', :sign_out => 'logout'}

  # 系统管理员认证部分
  devise_for :admins,
             :controllers => {:sessions => 'admin/admins/sessions'},
             :path => 'admin/auth',
             :path_names => { :sign_in => 'login', :sign_out => 'logout'}

  # 默认主页
  root :to => 'welcome#index'

  # 系统管理员route
  namespace :admin do
    root :to => 'dashboard#index'
    get 'dashboard' => 'dashboard#index'
    namespace :master do
      resources :admins, :except => [:index] do
        member do
          post :lock
        end
      end
      resources :admin_reports, :only => [:index]
      resources :roles, :except => [:index]
      resources :role_reports, :only => [:index]
      resources :properties, :except => [:index]
      resources :property_reports, :only => [:index]
      resources :sports, :except => [:index]
      resources :sport_reports, :only => [:index]
      resources :gym_reports, :only => [:index,:show] do
        member do
          post :approve
          post :reject
          post :lock
          post :destroy
        end
      end
    end
  end

  # 普通用户route
  namespace :user do
    root :to => 'dashboard#index'
    get 'dashboard' => 'dashboard#index'
    namespace :master do
      resources :gyms do
        member do
          post :apply
          post :cancel
          post :release
          post :suspend
        end
      end
      match 'gyms/upload_image' => 'gyms#upload_image',:via => :post
      match 'gyms/remove_image' => 'gyms#remove_image',:via => :post
      match 'gyms/get_cities_by_province_id/:province_id' => 'gyms#get_cities_by_province_id',:via=>:get
      match 'gyms/:id/get_cities_by_province_id/:province_id' => 'gyms#get_cities_by_province_id',:via=>:get
      match 'gyms/get_areas_by_city_id/:city_id' => 'gyms#get_areas_by_city_id',:via=>:get
      match 'gyms/:id/get_areas_by_city_id/:city_id' => 'gyms#get_areas_by_city_id',:via=>:get
      resources :courts, :except => [:index]
      resources :court_reports, :only => [:index]
      match 'courts/edit_court_properties_select/:sport_id' => 'courts#edit_court_properties_select',:via=>:get
      match 'courts/:id/edit_court_properties_select/:sport_id' => 'courts#edit_court_properties_select',:via=>:get
      resources :games, :except => [:index] do
        member do
          post :new_price_rule
          post :new_reservation_rule
        end
      end
      match 'games/delete_game_price_rule/:price_rule_id' => 'games#delete_game_price_rule',:via=>:get
      match 'games/delete_game_reservation_rule/:reservation_rule_id' => 'games#delete_game_reservation_rule',:via=>:get
      resources :game_reports, :only => [:index]
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
