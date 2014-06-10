class Weixin::Accounts::CurrentDealersController < Weixin::ApplicationController
  before_filter :authenticate_weixin_dealer!
  before_filter :set_weixin_current_dealer

  def show
  end

  def mine
  end

end