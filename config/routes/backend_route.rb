Carhall::Application.routes.draw do
  # Frontend pages
  # Dashboard
  resource :dashboard, only: :show do
    get :cooperations
    get :about_us
    get :help

    post :send_invitation
  end
  root to: 'dashboards#show'

  # Frontend sign_in/sing_up page
  devise_for :accounts, class_name: "Accounts::Account", module: "accounts"
  devise_scope :account do
    namespace :accounts do
      resource :confirmation
    end
  end

  resource :setting do
    get :template
    get :finance
    get :weixin
    get "weixin/:step", action: :weixin
  end

  namespace :statistic do
    resource :dashboard
    root to: 'dashboards#show'

    resources :distributors
    resources :dealers
    resources :providers
    resources :users

    resources :friends
    resources :user_friends
    resources :dealer_friends
    resources :distributor_friends
    resources :reviews do
      get :mending, on: :collection
      get :cleaning, on: :collection
    end

    resources :sales_cases
  end

  namespace :tips do
    resource :dashboard, only: :show
    root to: 'dashboards#show'

    resources :mendings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      resources :orders
    end

    resource :mending do
      get :orders
      get :edit_discount
      get :edit_brands
    end

    resources :cleanings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      resources :orders
    end

    resources :activities do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      get :in_progress, on: :collection
      get :expired, on: :collection
    end

    resources :bulk_purchasings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      get :in_progress, on: :collection
      get :expired, on: :collection

      resources :orders
    end

    resources :vip_cards do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      put :disable, on: :member
      put :reenable, on: :member

      resources :orders
    end

    resources :orders do
      get :mending, on: :collection
      get :cleaning, on: :collection
      get :test_driving, on: :collection
      get :bulk_purchasing, on: :collection
      get :bulk_purchasing2, on: :collection
      get :vehicle_insurance, on: :collection
      get :secondhand_appraise, on: :collection
      get :vip_card, on: :collection

      put :enable, on: :member
    end

    resources :purchase_requestings do
      get :in_progress, on: :collection
      get :expired, on: :collection

    end

    resources :bulk_purchasing2s do
      get :in_progress, on: :collection
      get :expired, on: :collection

      resources :orders
    end

    resources :test_drivings do
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member

      resources :orders
    end

    resources :manual_images
    resources :construction_cases
    resource :ad_template

    resources :buying_advices do
      resources :buying_advice_orders
    end
    resources :buying_advice_orders

  end

  namespace :bcst do
    resource :dashboard, only: :show
    root to: 'dashboards#show'


    resources :hosts
    resources :programme_lists
    resources :programmes do
      resources :comments
    end

    resources :exposures
    resources :traffic_reports
  end

  namespace :accounts do
    resources :admins

    resources :agents do
      put :accept, on: :member
      put :rank_down, on: :member
    end
    resources :distributors do
      put :accept, on: :member
      put :rank_up, on: :member
      put :rank_down, on: :member
    end
    resources :dealers do
      put :accept, on: :member
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member
      put :rank_up, on: :member
      put :rank_down, on: :member
    end
    resources :providers do
      put :accept, on: :member
      put :expose, on: :member
      put :hide, on: :member
      put :stick, on: :member
      put :unstick, on: :member
    end

    resources :users
    resources :candidates do
      get :president, on: :collection
      get :president, on: :member
      get :mechanic, on: :collection
      get :mechanic, on: :member
    end

    root to: "admins#index"
  end

  namespace :business do
    resources :adverts do
      get :client, on: :collection
      get :ad_template, on: :collection
      get :tutorial, on: :collection
    end
    resource :push
    resources :ad_templates
    resources :tutorials
    resources :client_versions

    root to: "adverts#index"
  end

  namespace :category do
    resources :brands
    resources :brand2s
    resources :brand3s
    resources :products
    
    root to: "brands#index"
  end

  namespace :posts do
    resources :posts do
      resources :comments, shallow: true
    end
    resources :clubs do
      delete :relieve_president, on: :member
      delete 'relieve_mechanic/:mechanic_id', action: :relieve_mechanic, on: :member
    end
    resources :president_candidates do
      put :appoint, on: :member
    end
    resources :mechanic_candidates do
      put :appoint, on: :member
    end
    
    root to: "posts#index"
  end

  namespace :dashboard do
    resources :bulk_purchasing2s do
      resources :bulk_purchasing2_orders
    end
    resources :purchase_requestings
    resources :distributors do
      get :manual_images, on: :member
      post :make_friend, on: :member
      delete :break, on: :member
    end
    resources :ad_templates do
      post :buy, on: :member
    end
    resources :tutorials
  end

end
