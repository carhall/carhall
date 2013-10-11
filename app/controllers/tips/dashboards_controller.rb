class Tips::DashboardsController < ApplicationController
  authorize_resource :tips
  before_filter :set_dealer

  helper StatisticsHelper

  def show
    flash[:alert] = "#{I18n.t(".unaccepted")}#{I18n.t(".can_not_use_tips")}" unless @user.accepted?
  end
  
end
