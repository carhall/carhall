class Tips::DashboardsController < ApplicationController
  ensure_base_user_type :dealer
  before_filter :set_dealer

  def show
    flash[:alert] = I18n.t(".unaccepted") unless @user.accepted?
  end
end
