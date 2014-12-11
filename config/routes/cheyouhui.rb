Carhall::Application.routes.draw do

	namespace :weixin do 
		namespace :cheyouhui do
			resources :groupons do 
                get :order,on: :member
                get :orders ,on: :collection
                post :order_create,on: :member
			end
			resources :free_tickets do 
				 get :order,on: :member
				 get :orders ,on: :collection
                post :order_create,on: :member

			end
			resources :cleanings do 
				get :order,on: :member
				get :orders ,on: :collection
                post :order_create,on: :member
			end
			resources :brand2s
			resources :buycars do
				get :buy,on: :collection
				post :buy_new,on: :collection
			end
			resources :my do
			   get :orders ,on: :collection
			end
			resources :mendings
		end
	end

	namespace :cheyouhui do
	   resources :settings
       resources :regions do
          get :managers,on: :collection
          put :accept,on: :collection
       end

       namespace :business do 
           resources :dealers
       end

       namespace :statistics do 
          resources :dealers
          resources :users
       end
	end
end