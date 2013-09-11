class Api::OrdersController < Api::ApplicationController
  ensure_base_user_type :user
  before_filter :set_parent
  before_filter :set_order, only: [:finish, :use, :cancel, :review]

  # GET /api/resources/1/orders
  # GET /api/resources/1/orders.json
  def index
    render_index @parent.orders
  end

  # GET /api/resources/1/orders/1
  # GET /api/resources/1/orders/1.json
  def show
    render_show @parent.orders.find(params[:id])
  end

  # POST /api/resources/1/orders
  # POST /api/resources/1/orders.json
  def create
    data_params = params.fetch(:data, {}).merge(user: current_base_user)
    render_create @parent.orders.new data_params
  end

  # PUT /api/resources/1/orders/1/finish
  # PUT /api/resources/1/orders/1/finish.json
  def finish
    @order.finish!

    render_accepted
  end

  # PUT /api/resources/1/orders/1/use
  # PUT /api/resources/1/orders/1/use.json
  def use
    @order.use! params.fetch(:count, 1)

    render_accepted
  end
  
  # PUT /api/resources/1/orders/1/cancel
  # PUT /api/resources/1/orders/1/cancel.json
  def cancel
    @order.cancel!

    render_accepted
  end

  # POST /api/resources/1/orders/1/review
  # POST /api/resources/1/orders/1/review.json
  def review
    @order.review_attributes = params[:data]
    render_create @order.review
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
        @parent = parent_class.find(value)
        return
      end
    end
  end

  def set_order
    @order = @parent.orders.find(params[:id])
    authorize! :update, @order
  end
end
