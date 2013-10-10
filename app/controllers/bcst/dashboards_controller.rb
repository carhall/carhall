class Bcst::DashboardsController < ApplicationController
  authorize_resource :bcst
  before_filter :set_provider

  def show
    flash[:alert] = "#{I18n.t(".unaccepted")}#{I18n.t(".can_not_use_tips")}" unless @user.accepted?
  end
  
end
