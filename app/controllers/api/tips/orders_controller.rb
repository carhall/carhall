class Api::Tips::OrdersController < Api::ApplicationController
  set_resource_class ::Tips::Order, detail: true
  before_filter :set_order, only: [:finish, :use, :cancel, :review]
  before_filter :set_filter

  def set_filter
    filter_parent :state
    if params[:filter]
      if params[:filter][:order_type]
        order_type = {
          'mending_order' => [Tips::MendingOrder],
          'cleaning_order' => [Tips::CleaningOrder],
          'bulk_purchasing_order' => [Tips::BulkPurchasingOrder],
        }
        sql_where_query = order_type[params[:filter][:order_type]].map{|k|"type = '#{k.name}'"}.join(' or ')
        @parent = @parent.where(sql_where_query)
      end
    end
  end

  # POST /api/resources/1/orders
  # POST /api/resources/1/orders.json
  def create
    render_create @parent.new order_params.merge(user: current_user)
  end

  # PUT /api/resources/1/orders/1/finish
  # PUT /api/resources/1/orders/1/finish.json
  def finish
    @order.finish
    render_update @order
  end

  # PUT /api/resources/1/orders/1/use
  # PUT /api/resources/1/orders/1/use.json
  def use
    @order.use params.fetch(:count, 1)
    render_update @order
  end
  
  # PUT /api/resources/1/orders/1/cancel
  # PUT /api/resources/1/orders/1/cancel.json
  def cancel
    @order.cancel
    render_update @order
  end

  # POST /api/resources/1/orders/1/review
  # POST /api/resources/1/orders/1/review.json
  def review
    render_create @order.create_review review_params
  end

protected

  AccreditedKeys = {
    'mending_id' => ::Tips::Mending,
    'cleaning_id' => ::Tips::Cleaning,
    'bulk_purchasing_id' => ::Tips::BulkPurchasing,
    'dealer_id' => ::Accounts::Dealer,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value).orders.includes(:dealer, :user, :source)
        return
      end
    end
    @parent = current_user.orders.includes(:dealer, :user, :source)
  end

  def set_order
    @order = @parent.find(params[:id])
    authorize! :update, @order
  end

private
  
  def order_params
    params.require(:data).permit(:count, 
      detail: [:id, :brand_id, :brand, :series, :plate_num, 
        :arrive_at, :description, :mending_type_id, :mending_type]
    )
  end

  def review_params
    params.require(:data).permit(:content, :stars)
  end

end
