class Api::Tips::CleaningOrdersController < Api::Tips::OrdersController
  before_filter :set_current_user
  set_resource_class ::Tips::CleaningOrder, detail: true
  before_filter :set_order, only: [:finish, :use, :cancel, :review]
  before_filter :set_filter

  def set_parent
    @parent = @current_user.cleaning_orders
  end

  def set_filter
    filter_parent :state
  end
  
end