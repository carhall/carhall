class Weixin::Cheyouhui::MyController < Weixin::Cheyouhui::ApplicationController
  def index
  end

  def orders
  	type = params[:type]
  	case type
  	when "cleaning"
      @orders = @user.cleaning_orders
  	when "mending"
      @orders = @user.cleaning_orders
  	when "groupons"
      @orders = @user.bulk_purchasing_orders
  	when "free_ticket"
      @orders = @user.free_ticket_orders
  	end
  		
  end

  def show
  end
end
