class Weixin::Accounts::CurrentUsersController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user
  before_filter :make_friend_with_dealer

  def show
  end

  def mine
  end

protected

  def make_friend_with_dealer
    if params[:dealer_id]
      @dealer = Accounts::Dealer.find(params[:dealer_id])
      @user.make_friend_with! @dealer unless @user.is_friend? @dealer
    end
  end

end