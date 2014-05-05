class Weixin::Tips::OrdersController < Weixin::ApplicationController
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :vip_card, class: Tips::VipCard

  before_filter :get_source
  before_filter :set_weixin_current_user, only: [:new, :create]

  def index
    @orders = @source.orders
  end

  def new
    @order = @source.orders.new
  end

  def create
    count = params.require(:order).require(:count)
    @order = @source.orders.new(count: count, user: @user)
  end

  def thank_you
    count = params.require(:order).require(:count)
    @order = @source.orders.create(count: count, user: @user)
    render "create" unless @order.errors.empty?
  end

private

  def get_source
    @source = @mending || @cleaning || @bulk_purchasing || @vip_card
  end
  
end