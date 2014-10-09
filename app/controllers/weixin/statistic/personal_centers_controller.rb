class Weixin::Statistic::PersonalCentersController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user
  before_filter :set_dealer
  def index
  end

  def data_from_api
  	 request_param = get_param_from_data_type
  	 data= Java::Base.get(request_param.to_query)
  	 #binding.pry
  	 @result = data.json
     render_template
  	 #return render :text =>"没有相关记录" if result["result"]=="N"


  end

  private

  def set_dealer
    @dealer =  Accounts::Dealer.find params[:dealer_id] rescue nil
  end

  def render_template
  	return render  params[:data_type]
  
  end
  def get_param_from_data_type
  	hash = {mobile: @user.mobile,shopuserid: params[:dealer_id],rnd: Time.now.to_i}
  	#hash = {mobile: 18053932727,shopuserid: 2,rnd: Time.now.to_i}
  	param = {}
  	case params[:data_type]

  	when "mobile_card"
      param = {method: "queryCardInfo"}
    when "consume"
  	  param = {method: "expense_query"}
  	when "jifen"
  	  param = {method: "expense_query"}
  	when "deposit","store"
  	  param = {method: "deposit_query"}
  	when "exchange_history"
  	  param = {method: "pointExchangeHistory"}
  	when "message"
  	  param = {method: "userMessageList"}
  	
  	end

  	return hash.merge(param)

  		
  end
end
