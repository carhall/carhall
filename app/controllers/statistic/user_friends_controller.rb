class Statistic::UserFriendsController < Statistic::FriendsController
    
  def index
    @friends = @user.user_friends
  end
end