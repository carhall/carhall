class Tips::DashboardsController < ApplicationController
  before_filter :set_dealer

  helper StatisticsHelper

  def show
    flash[:alert] = "#{I18n.t(".unaccepted")}#{I18n.t(".can_not_use_tips")}" unless @user.accepted?
  end
  
end
