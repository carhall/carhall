class Bcst::DashboardsController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_provider

  helper StatisticsHelper

  def show
    flash[:alert] = "#{I18n.t(".unaccepted")}#{I18n.t(".can_not_use_tips")}" unless @user.accepted?
  end
  
end
