class Cheyouhui::Statistics::UsersController < ApplicationController
  def index
  	@users = Accounts::Wechat.where("region_id=?",@user.region_id)
  end
end
