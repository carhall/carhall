class Weixin::Accounts::CurrentUsersController < Weixin::ApplicationController
  before_filter :authenticate_account!
  before_filter :set_current_user

  def show
  end

end