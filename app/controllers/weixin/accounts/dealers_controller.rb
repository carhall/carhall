class Weixin::Accounts::DealersController < Weixin::ApplicationController
  set_resource_class ::Accounts::Dealer

 

  def rescue
  	@rescue = Tips::RescueOrder.new
  end

end