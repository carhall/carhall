class Api::Tips::CleaningOrdersController < Api::Tips::OrdersController

  def set_parent
    @parent = @current_user.cleaning_orders
  end
  
end