class Tips::OrdersController < Tips::ApplicationController
  before_filter :set_parent
  set_resource_class Tips::Order, :through => :parent

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
    render @parent_type
  end

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
        @parent_type = key.gsub('_id', '')
        @parent = parent_class.find(value)
        return
      end
    end
  end

  
end
