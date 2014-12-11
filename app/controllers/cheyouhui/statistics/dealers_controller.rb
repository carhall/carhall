class Cheyouhui::Statistics::DealersController < ApplicationController
  def index
  	 @dealers = Accounts::Dealer.accepted.where("region_id=?",@user.region_id)
  end
end
