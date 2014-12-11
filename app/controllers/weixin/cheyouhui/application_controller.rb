class Weixin::Cheyouhui::ApplicationController < Weixin::ApplicationController
	#before_filter :logout_others
	before_filter :authenticate_user_form_token
	#before_filter :authenticate_weixin_account!
	before_filter :set_current_user
	before_filter :dealers_from_region

	def authenticate_user_form_token
		logout_others
		unless @user.present?
			token = session["weixin_token"] ||  params["token"]
		   u = Accounts::Wechat.find_by(weixin_open_id: token)    
		   sign_in(u)
		   session["weixin_token"] = token
           @user = current_account
	    end
	end

	def logout_others
    sign_out :account
    sign_out :weixin_dealer
    sign_out :weixin_account
   end

   def dealers_from_region
   	  region_id = @user.region_id || Cheyouhui::Region.first.id
   	  @dealers = Accounts::Dealer.where("region_id=?",region_id)

   end

  
end