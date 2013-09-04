class InverseFriendsController < ApplicationController
  ensure_base_user_type :provider, :dealer, :admin
  
  def index
    @inverse_friends = current_base_user.inverse_friends
    render layout: current_base_user.user_type.to_s
  end
end