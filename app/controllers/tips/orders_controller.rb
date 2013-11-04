class Tips::OrdersController < Tips::ApplicationController
  before_filter :set_distributor, only: :bulk_purchasing2
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :bulk_purchasing2, class: Tips::BulkPurchasing2
  set_resource_class Tips::Order, through: [:mending, :cleaning, :bulk_purchasing, :bulk_purchasing2], 
    shallow: true

  def mending
    @orders = @dealer.mending_orders
  end

  def cleaning
    @orders = @dealer.cleaning_orders
  end
  
  def bulk_purchasing
    @orders = @dealer.bulk_purchasing_orders
  end

  def bulk_purchasing2
    @orders = @distributor.bulk_purchasing2_orders
  end

  def index
    render 'mending' if @mending
    render 'cleaning' if @cleaning
    render 'bulk_purchasing' if @bulk_purchasing
    render 'bulk_purchasing2' if @bulk_purchasing2
  end

end
