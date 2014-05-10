class Weixin::Accounts::DealersController < Weixin::ApplicationController
  set_resource_class ::Accounts::Dealer

  def current_user
  end

end