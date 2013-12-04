class Api::Tips::VipCardOrdersController < Api::Tips::OrdersController
  before_filter :set_current_user
  set_resource_class ::Tips::VipCardOrder, detail: true
  before_filter :set_order, only: [:finish, :use, :cancel, :review]
  before_filter :set_filter

  def set_parent
    @parent = @current_user.vip_card_orders.includes(:vip_card_order_items)
  end

  def set_filter
    filter_parent :state
  end

  def use
    @order.use params[:data][:item_id], params[:data][:count].to_i
    render_update @order
  end

end