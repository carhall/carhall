class Weixin::Cheyouhui::FreeTicketsController <Weixin::Cheyouhui::ApplicationController
  
   def index
  	 @free_tickets = ::Tips::FreeTicket.in_progress.where("dealer_id in(?)",@dealers.map(&:id))

  end

  def show
  	@free_ticket = ::Tips::FreeTicket.find params[:id]
  	@dealer = @free_ticket.dealer
  end

  def order
  	@order = Tips::Order.new
  	@source = ::Tips::FreeTicket.find params[:id]
  	@dealer = @source.dealer
  end

  def order_create
     @source = ::Tips::FreeTicket.find params[:id]
  	 @dealer = @source.dealer
  	 @order = @source.orders.new(params.require(:order).permit!)
  	 @order.weixin_user = @user
    if @order.save
      msg = "您成功购买了 #{@source.title} 。"
      flash[:success] = msg
      redirect_to action: :index
    else
      render :new
    end

  end
end
