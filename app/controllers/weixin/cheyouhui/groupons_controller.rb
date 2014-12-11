class Weixin::Cheyouhui::GrouponsController < Weixin::Cheyouhui::ApplicationController
	
  def index
  	 @bulk_purchasings = ::Tips::BulkPurchasing.in_progress.where("dealer_id in(?)",@dealers.map(&:id))
  end

  def show
  	@bulk_purchasing = ::Tips::BulkPurchasing.find params[:id]
  	@dealer = @bulk_purchasing.dealer
  end

  def order
  	@order = Tips::Order.new
  	@source = ::Tips::BulkPurchasing.find params[:id]
  	@dealer = @source.dealer
  end

  def order_create
     @source = ::Tips::BulkPurchasing.find params[:id]
  	 @dealer = @source.dealer
  	 @order = @source.orders.new(params.require(:order).permit!)
  	 @order.weixin_user = @user
    if @order.save
      msg = "您成功购买了 #{@order.title} 。"
      flash[:success] = msg
      redirect_to action: :index
    else
      render :new
    end

  end
end
