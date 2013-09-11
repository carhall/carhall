class Tips::DashboardsController < ApplicationController
  ensure_user_type :dealer
  before_filter :set_dealer

  def show
    flash[:alert] = "#{I18n.t(".unaccepted")}#{I18n.t(".can_not_use_tips")}" unless @user.accepted?
  end
end
