class Api::Tips::OrdersController < Api::ApplicationController
  before_filter :set_current_user
  set_resource_class ::Tips::Order, detail: true
  before_filter :set_includes, only: :index
  before_filter :set_order, only: [:finish, :use, :cancel, :review]
  before_filter :set_filter

  def render_index resources, template=:list
    super
  end

  # POST /api/resources/1/orders
  # POST /api/resources/1/orders.json
  def create
    render_create @parent.new order_params.merge(user: @current_user)
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
    @order.use params.fetch(:count, 1).to_i
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
    render_create @order.build_review review_params
  rescue ActiveRecord::RecordNotSaved
    render_error I18n.t('review_exist'), :unprocessable_entity
  end

protected

  AccreditedKeys = {
    'mending_id' => ::Tips::Mending,
    'cleaning_id' => ::Tips::Cleaning,
    'bulk_purchasing_id' => ::Tips::BulkPurchasing,
    'vip_card_id' => ::Tips::VipCard,
    'dealer_id' => ::Accounts::Dealer,
  }
  
  OrderTypes = {
    'mending_order' => ::Tips::MendingOrder,
    'cleaning_order' => ::Tips::CleaningOrder,
    'bulk_purchasing_order' => ::Tips::BulkPurchasingOrder,
    'vip_card_order' => ::Tips::VipCardOrder,
  }

  def set_parent
    if params[:filter] && params[:filter][:order_type]
      klass = OrderTypes[params[:filter][:order_type]]
      @parent = klass.with_user(@current_user)
      @parent = @parent.includes(:detail) if klass == Tips::MendingOrder
      @parent = @parent.includes(:vip_card_order_items) if klass == Tips::VipCardOrder
    else
      params.each do |key, value|
        if AccreditedKeys.keys.include? key
          klass = AccreditedKeys[key]
          @parent = klass.find(value).orders
          @parent = @parent.includes(:detail) if klass == Tips::Mending
          @parent = @parent.includes(:vip_card_order_items) if klass == Tips::VipCard
          return
        end
      end
      @parent = @current_user.orders
    end
    @parent ||= ::Accounts::Account.all
  end

  def set_includes
    @parent = @parent.includes(:user, :dealer, :review)
  end

  def set_filter
    filter_parent :state
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
