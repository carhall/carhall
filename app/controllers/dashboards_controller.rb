class DashboardsController < ApplicationController
  def show
    case current_base_user_type
    when :provider, :dealer, :admin
      render current_base_user_type, layout: current_base_user_type.to_s
    else
      render 'welcome'
    end
  end
end
