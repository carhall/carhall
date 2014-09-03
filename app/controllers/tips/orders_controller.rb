class Tips::OrdersController < Tips::ApplicationController
  before_filter :set_distributor, only: :bulk_purchasing2
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :test_driving, class: Tips::TestDriving
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :bulk_purchasing2, class: Tips::BulkPurchasing2
  load_resource :vip_card, class: Tips::VipCard
  load_resource :rescue_orders, class: Tips::RescueOrder

  set_resource_class Tips::Order, through: [:mending, :cleaning, :test_driving,
    :bulk_purchasing, :bulk_purchasing2, :vip_card,:rescue_oders], shallow: true

  def mending
    @orders = @dealer.mending_orders
  end

  def cleaning
    @orders = @dealer.cleaning_orders
  end

  def test_driving
    @orders = @dealer.test_driving_orders
  end
  
  def bulk_purchasing
    @orders = @dealer.bulk_purchasing_orders
  end
  
  def vehicle_insurance
    @orders = @dealer.vehicle_insurance_orders
  end
  
  def secondhand_appraise
    @orders = @dealer.secondhand_appraise_orders
  end

  def bulk_purchasing2
    @orders = @distributor.bulk_purchasing2_orders
  end

  def vip_card
    @orders = @dealer.vip_card_orders
    render 'vip_cards'
  end

  def rescue_orders
  	@orders = @dealer.rescue_orders
  end

  def enable
    @order = Tips::Order.find(params[:id])
    @order.enable!
    flash[:success] = i18n_message(:enable_success)
    redirect_to :back
  end

  def index
    render 'mending' if @mending
    render 'cleaning' if @cleaning
    render 'test_driving' if @test_driving
    render 'bulk_purchasing' if @bulk_purchasing
    render 'bulk_purchasing2' if @bulk_purchasing2
    render 'vip_cards' if @vip_card
  end

  def show
    render 'vip_card'
  end
end
