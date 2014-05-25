class Weixin::Accounts::CurrentUsersController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user

  def show
  end

  def mine
  end

end