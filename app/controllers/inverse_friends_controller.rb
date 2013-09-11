class InverseFriendsController < ApplicationController
  ensure_user_type :provider, :dealer, :admin
  
  def index
    @inverse_friends = @user.inverse_friends
  end
end