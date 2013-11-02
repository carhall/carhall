class Statistic::FriendsController < Statistic::ApplicationController
  authorize_resource class: Accounts::Friendship
  
  helper StatisticsHelper
    
  def index
    @friends = @user.user_friends
  end
end