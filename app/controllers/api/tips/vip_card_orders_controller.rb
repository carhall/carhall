class Api::Tips::VipCardOrdersController < Api::Tips::OrdersController

  def set_parent
    @parent = @current_user.vip_card_orders.includes(:vip_card_order_items)
  end

  def use
    @order.use params.require(:data).require(:item_id), params.require(:data).fetch(:count, 1).to_i
    render_update @order
  end

  def review
    render_create @order.build_review params.require(:data).require(:item_id), review_params
  rescue ActiveRecord::RecordNotSaved
    render_error I18n.t('review_exist'), :unprocessable_entity
  end

end