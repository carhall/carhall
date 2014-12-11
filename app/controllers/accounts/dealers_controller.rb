class Accounts::DealersController < Accounts::ApplicationController
  set_resource_class Accounts::Dealer, accept: true, display: true, rank: true, weixin: true
  
  def set_cheyouhui
  	@dealer = Accounts::Dealer.find params[:id]

  end
  def add_cheyouhui
  	#binding.pry
  	@dealer = Accounts::Dealer.find params[:id]
  	@dealer.region_id = params[:accounts_dealer][:region_id]
  	@dealer.save
  	redirect_to accounts_dealers_path,notice: "设置成功"

  end
end