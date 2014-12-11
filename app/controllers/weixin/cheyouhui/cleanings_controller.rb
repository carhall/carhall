class Weixin::Cheyouhui::CleaningsController < Weixin::Cheyouhui::ApplicationController
  
   def index
   	 type = params["type"]=="mending" ? "mending" : "cleaning"
  	 @cleanings = ::Tips::Cleaning.where("is_cheyouhui=1 and cleaning_type_id=1 and dealer_id in(?)",@dealers.map(&:id)) if type=="cleaning"
  	 @cleanings = ::Tips::Cleaning.where("is_cheyouhui=1 and cleaning_type_id=5 and dealer_id in(?)",@dealers.map(&:id)) if type=="mending"
  end

  def show
  	@cleaning = ::Tips::Cleaning.find params[:id]
  	@dealer = @cleaning.dealer
  end

  def orders
  	 @orders = @user.cleaning_orders
  end

  def order
  	@order = Tips::Order.new
  	@source = ::Tips::Cleaning.find params[:id]
  	@dealer = @source.dealer
  end

  def order_create
     @source = ::Tips::Cleaning.find params[:id]
  	 @dealer = @source.dealer

  	 
  	 @order = @source.orders.new(params.require(:order).permit!)
  	 @order.weixin_user = @user
  	 @order.cleaning_type_id = @source.cleaning_type_id
    if @order.save
      msg = "您成功购买了 #{@order.title} 。"
      flash[:success] = msg
      redirect_to action: :index
    else
      render :new
    end

  end
end

