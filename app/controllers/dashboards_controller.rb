class DashboardsController < ApplicationController
  def index
    if base_user_signed_in?
      case current_base_user.user_type
      when :provider
        render layout: 'provider'
      when :dealer
        render layout: 'dealer'
      when :admin
        render layout: 'admin'
      else
        raise CanCan::AccessDenied
      end
    else
      render 'welcome'
    end
  end
end
