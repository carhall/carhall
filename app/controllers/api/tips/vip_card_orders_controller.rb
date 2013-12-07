class Api::Tips::VipCardOrdersController < Api::Tips::OrdersController

  def set_parent
    @parent = @current_user.vip_card_orders.includes(:vip_card_order_items)
  end

  def use
    @order.use params[:data][:item_id], params[:data][:count].to_i
    render_update @order
  end

end