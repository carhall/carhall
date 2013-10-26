class Statistic::InverseFriendsController < Statistic::ApplicationController
  authorize_resource class: Accounts::Friendship
  
  helper StatisticsHelper
    
  def index
    @inverse_friends = @user.inverse_friends
  end
end