class Weixin::Tips::VipCardOrdersController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user

  def index
    @vip_card_orders = @user.vip_card_orders
  end

  def show
    @vip_card_order = @user.vip_card_orders.find(params[:id])
  end
end