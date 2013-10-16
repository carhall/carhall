class Tips::OrdersController < Tips::ApplicationController
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  set_resource_class Tips::Order, :through => [:mending, :cleaning, :bulk_purchasing], shallow: true

  def mending
    @orders = @dealer.mending_orders
  end

  def cleaning
    @orders = @dealer.cleaning_orders
  end
  
  def bulk_purchasing
    @orders = @dealer.bulk_purchasing_orders
  end

  def index
    render 'mending' if @mending
    render 'cleaning' if @cleaning
    render 'bulk_purchasing' if @bulk_purchasing
  end

end
