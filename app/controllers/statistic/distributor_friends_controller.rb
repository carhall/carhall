class Statistic::DistributorFriendsController < Statistic::FriendsController
    
  def index
    @friends = @user.distributor_friends
  end
end