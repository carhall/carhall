class Api::Tips::MendingOrdersController < Api::Tips::OrdersController

  def set_parent
    @parent = @current_user.mending_orders.includes(:detail)
  end

end