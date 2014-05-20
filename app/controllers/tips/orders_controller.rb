class Tips::OrdersController < Tips::ApplicationController
  before_filter :set_distributor, only: :bulk_purchasing2
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :bulk_purchasing2, class: Tips::BulkPurchasing2
  load_resource :vip_card, class: Tips::VipCard
  before_filter :load_resource_test_drive
  set_resource_class Tips::Order, through: [:mending, :cleaning, :test_drive, 
    :bulk_purchasing, :bulk_purchasing2, :vip_card], shallow: true

  def mending
    @orders = @dealer.mending_orders
  end

  def cleaning
    @orders = @dealer.cleaning_orders
  end

  def test_drive
    @orders = @dealer.test_drive_orders
  end
  
  def bulk_purchasing
    @orders = @dealer.bulk_purchasing_orders
  end

  def bulk_purchasing2
    @orders = @distributor.bulk_purchasing2_orders
  end

  def vip_card
    @orders = @dealer.vip_card_orders
    render 'vip_cards'
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
    render 'test_drive' if @test_drive
    render 'bulk_purchasing' if @bulk_purchasing
    render 'bulk_purchasing2' if @bulk_purchasing2
    render 'vip_cards' if @vip_card
  end

  def show
    render 'vip_card'
  end

  def load_resource_test_drive
    @test_drive = Tips::TestDrive.find(params[:test_drife_id]) if params[:test_drife_id]
  end
end
