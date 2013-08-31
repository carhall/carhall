class InverseFriendsController < ApplicationController
  def index
    @inverse_friends = current_base_user.inverse_friends
    render layout: current_base_user.user_type.to_s
  end
end