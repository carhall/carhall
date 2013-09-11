class InverseFriendsController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_current_user
    
  def index
    @inverse_friends = @user.inverse_friends
  end
end