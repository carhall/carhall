Carhall::Application.routes.draw do
  namespace :weixin do
    devise_for :accounts, class_name: "Accounts::Account", module: "weixin/accounts"
    devise_scope :account do
      namespace :accounts do
        resource :confirmation
        get :check, to: "weixin/accounts/registrations#check"
      end
    end

    devise_for :dealers, class_name: "Accounts::Dealer", module: "weixin/dealers"

    scope module: :accounts do
      resources :dealers do
        get :rescue, on: :member
      end
      resources :distributors
      resource :current_user
      resource :current_dealer 
    end

    scope module: :statistic do
      resources :dealers do
        resource :current_user do
          resources :personal_centers ,only: [:index] do 
             get "data/:data_type" ,action: :data_from_api,on: :collection
          end
          resources :consumption_records, only: [:show, :index]
          resources :sales_cases, only: [:show, :index]
        end
      end
    end

    scope module: :tips do
      resources :dealers do
      	resource :rescues ,:only=>[] do
      		resources :orders, only: [:index,:create], type: "rescue" do
                post :create_confirmation, on: :collection
            end
      	end 
        resource :mending, only: [:show] do
          resources :orders, only: [:index, :new, :create], type: "mending" do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
          resources :reviews, only: [:index]
        end
        resources :cleanings, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
          resources :reviews, only: [:index]
          get "cleaning_type/:cleaning_type_id", as: :cleaning_type, 
            action: :index, on: :collection
        end
        resources :activities, only: [:show, :index]
        resources :bulk_purchasings, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
          resources :reviews, only: [:index]
        end
        resources :vip_cards, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
          resources :reviews, only: [:index]
        end
        resource :vehicle_insurance, only: [] do
          resources :orders, only: [:index, :new, :create], type: "vehicle_insurance" do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
        end
        resource :secondhand_appraise, only: [] do
          resources :orders, only: [:index, :new, :create], type: "secondhand_appraise" do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
        end
        resources :test_drivings, only: [:show, :index] do
          resources :orders, only: [:index, :new, :create] do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
        end
        resources :construction_cases do
          get "product/:product_id", on: :collection, 
            action: :product, as: :product
        end
        resource :current_user do
          get ":type/orders", as: :type_orders, to: "orders#index"
          get ":type/orders/:id", as: :type_order, to: "orders#show"
        end
      end

      resources :distributors do
        resources :manual_images do
          get "category/:category", on: :collection, 
            action: :category, as: :category
        end
        resources :construction_cases do
          get "product/:product_id", on: :collection, 
            action: :product, as: :product
        end
        resources :ad_templates do
          get "product/:product_id", on: :collection, 
            action: :product, as: :product
        end
        resources :bulk_purchasing2s do
          resources :bulk_purchasing2_orders, as: :orders, 
            only: [:index, :new, :create] do
            post :create_confirmation, on: :collection
            get "use/:count", action: :use_confirmation, on: :member
            put :use, on: :member
          end
        end
        resource :current_user do
          get ":type/orders", as: :type_orders, to: "orders#index"
          get ":type/orders/:id", as: :type_order, to: "orders#show"
        end
      end

      resources :construction_cases do
        get "product/:product_id", on: :collection, 
          action: :product, as: :product
      end
      resources :ad_templates do
        get "product/:product_id", on: :collection, 
          action: :product, as: :product
      end

      resources :brand2s
      resource :current_user do
        resource :buying_advice do
          get "destroy", as: :destroy
        end
      end
    end

    root to: "accounts/current_users#show"
  end
  
  mount WeixinAPI => '/weixin'

end
