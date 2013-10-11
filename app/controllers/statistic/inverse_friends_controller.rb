class Statistic::InverseFriendsController < Statistic::ApplicationController
  authorize_resource class: Accounts::Friendship
  before_filter :set_current_user
  
  helper StatisticsHelper
    
  def index
    @inverse_friends = @user.inverse_friends
  end
end