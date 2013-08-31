class DashboardsController < ApplicationController
  def show
    if base_user_signed_in?
      user_type = current_base_user.user_type
      case user_type
      when :provider, :dealer, :admin
        render user_type, layout: user_type.to_s
      else
        raise CanCan::AccessDenied
      end
    else
      render 'welcome'
    end
  end
end
