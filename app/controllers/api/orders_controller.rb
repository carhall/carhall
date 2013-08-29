class Api::OrdersController < Api::BaseController
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
    render_create @parent.orders.create (params[:data]||{}).merge(user: current_base_user)
  end

  # PUT /api/resources/1/orders/1/finish
  # PUT /api/resources/1/orders/1/finish.json
  def finish
    @order.find(params[:id]).finish!

    render_accepted :accepted
  end

  # PUT /api/resources/1/orders/1/use
  # PUT /api/resources/1/orders/1/use.json
  def use
    @order.use! params[:count]

    render_accepted :accepted
  end
  
  # PUT /api/resources/1/orders/1/cancel
  # PUT /api/resources/1/orders/1/cancel.json
  def cancel
    @order.cancel!

    render_accepted :accepted
  end

  # POST /api/resources/1/orders/1/review
  # POST /api/resources/1/orders/1/review.json
  def review
    render_create Review.create (params[:data]||{}).merge(order: @order)
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
    @order = @parent.orders.user(current_base_user).find(params[:id])
  end
end
