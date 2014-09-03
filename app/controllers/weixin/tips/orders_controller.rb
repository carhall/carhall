class Weixin::Tips::OrdersController < Weixin::ApplicationController
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :test_driving, class: Tips::TestDriving
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :vip_card, class: Tips::VipCard
  load_resource :rescue, class: Tips::RescueOrder

  before_filter :authenticate_weixin_account!, except: [:index]
  before_filter :set_weixin_current_user, except: [:index]
  before_filter :get_parent
  before_filter :get_parent_with_user, except: [:index, :show]

  def index
    @orders = @parent
  end

  def show
    @order = @parent.find(params[:id])
  end

  def new
    @order = @parent.new
  end

  def create_confirmation
    @order = @parent.new(params.require(:order).permit!)
  end

  def create
    @order = @parent.new(params.require(:order).permit!)
    if @order.save
      msg = get_msg_from_type
      flash[:success] = msg
      redirect_to weixin_root_path
    else
      render :new
    end
  end

  def use_confirmation
    @count = params[:count].to_i
    @order = @parent.find(params[:id])
  end

  def use
    @count = params[:count].to_i
    @order = @parent.find(params[:id])
    @order.use @count
    @order.save
  end

private

  def get_parent
    @dealer = params[:dealer_id]
    @distributor = params[:distributor_id]
    if params[:type]
      get_type_parent
    else
      get_source_parent
    end
  end

  def get_source_parent
    @source = @mending || @cleaning || @test_driving || @bulk_purchasing || @vip_card 
    @parent = @source.orders
  end
  
  def get_type_parent
    @user = authenticate_weixin_account!
    @parent = case params[:type]
      when "mending"
        @mending = Tips::Mending.find_by(dealer_id: @dealer)
        @user.mending_orders
      when "bulk_purchasing"
        @user.bulk_purchasing_orders
      when "vip_card"
        @user.vip_card_orders
      when "vehicle_insurance"
        @user.vehicle_insurance_orders
      when "secondhand_appraise"
        @user.secondhand_appraise_orders
      when "rescue"
        @user.rescue_orders 
      else
        raise ActionController::RoutingError, "Unknown order type: #{params[:type]}"
      end
    @parent = @parent.with_dealer(@dealer)
  end

  def get_msg_from_type

  	if  params[:type].blank?
       case @order.class.to_s
       when  "Tips::TestDrivingOrder"
       	return "您成功预约了 #{@order.source.try(:title)} 。稍后会有工作人员与您取得联系。"
       end
  	else
  	   case  params[:type]
  	   when  "vehicle_insurance"
  		  return "您成功递交了 #{@order.title} 。稍后会有工作人员与您取得联系。"
  	   when "mending"
  		  return "您成功预约了 #{@order.title} 。稍后会有工作人员与您取得联系。"
  	   when  "secondhand_appraise"
  		  return "您成功递交了 #{@order.title} 。"
  		when "rescue"
  		  return "您已申请救援，稍后工作人员跟你联系"
  	   else
  		  return "您成功购买了 #{@order.title} 。"
  	   end 
  	end 	
  	return "您成功购买了 #{@order.title} 。"	
  end

  def get_parent_with_user
    @parent = @parent.with_user(@user)
  end

end