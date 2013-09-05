class InverseFriendsController < ApplicationController
  ensure_base_user_type :provider, :dealer, :admin
  
  def index
    @inverse_friends = @user.inverse_friends
    render layout: @user_type.to_s
  end
end