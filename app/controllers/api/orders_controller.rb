class Api::OrdersController < Api::ApplicationController
  before_filter :set_current_user, only: :create
  before_filter :set_parent
  before_filter :set_order, only: [:finish, :use, :cancel, :review]

  set_resource_class Order, detail: true
  attr_reader :parent

  # POST /api/resources/1/orders
  # POST /api/resources/1/orders.json
  def create
    data_params = params.fetch(:data, {}).merge(user: @current_user)
    render_create @parent.new data_params
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
    render_create @order.create_review params[:data]
  end

  protected

  AccreditedKeys = {
    'mending_id' => Mending,
    'cleaning_id' => Cleaning,
    'bulk_purchasing_id' => BulkPurchasing,
    'dealer_id' => Dealer,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value).orders
        return
      end
    end
  end

  def set_order
    @order = @parent.find(params[:id])
    authorize! :update, @order
  end
end
