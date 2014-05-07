class Weixin::Tips::OrdersController < Weixin::ApplicationController
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :vip_card, class: Tips::VipCard

  before_filter :get_source
  before_filter :authenticate_weixin_account!, except: [:index]
  before_filter :set_weixin_current_user, except: [:index]

  def index
    @orders = @source.orders
  end

  def new
    @order = @source.orders.new(user: @user)
  end

  def create_confirmation
    count = params.require(:order).require(:count)
    @order = @source.orders.new(count: count, user: @user)
  end

  def create
    count = params.require(:order).require(:count)
    @order = @source.orders.create(count: count, user: @user)
  end

  def use_confirmation
    @count = params[:count].to_i
    @order = @user.orders.find(params[:id])
  end

  def use
    @count = params[:count].to_i
    @order = @user.orders.find(params[:id])
    @order.use @count
    @order.save
  end

private

  def get_source
    @source = @mending || @cleaning || @bulk_purchasing || @vip_card
  end
  
end