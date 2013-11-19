class Statistic::DealerFriendsController < Statistic::FriendsController
    
  def index
    @friends = @user.dealer_friends
  end
end