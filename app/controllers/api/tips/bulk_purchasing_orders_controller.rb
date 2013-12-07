class Api::Tips::BulkPurchasingOrdersController < Api::Tips::OrdersController

  def set_parent
    @parent = @current_user.bulk_purchasing_orders
  end
  
end