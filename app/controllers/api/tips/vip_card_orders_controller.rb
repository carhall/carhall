class Api::Tips::VipCardOrdersController < Api::Tips::OrdersController

  def set_parent
    @parent = @current_user.vip_card_orders.includes(:vip_card_order_items)
  end

  def use
    @order.use params[:data][:item_id], params[:data].fetch(:count, 1).to_i
    render_update @order
  end

  def review
    render_create @order.create_review params[:data][:item_id], review_params
  end

end