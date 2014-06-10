class Weixin::Tips::BulkPurchasing2OrdersController < Weixin::ApplicationController
  load_resource :bulk_purchasing2, class: Tips::BulkPurchasing2
  
  before_filter :authenticate_weixin_dealer!, except: [:index]
  before_filter :set_weixin_current_dealer, except: [:index]
  before_filter :get_parent
  before_filter :get_parent_with_dealer, except: [:index, :show]

  def index
    @orders = @parent
  end

  def show
    @order = @parent.find(params[:id])
  end

  def new
    @order = @parent.new
  end

  def create_confirmation
    @order = @parent.new(params.require(:order).permit!)
  end

  def create
    @order = @parent.create(params.require(:order).permit!)
  end

  def use_confirmation
    @count = params[:count].to_i
    @order = @parent.find(params[:id])
  end

  def use
    @count = params[:count].to_i
    @order = @parent.find(params[:id])
    @order.use @count
    @order.save
  end

private

  def get_parent
    @distributor = params[:distributor_id]
    @source = @bulk_purchasing2
    @parent = @source.orders
  end

  def get_parent_with_dealer
    @parent = @parent.with_dealer(@user)
  end
end