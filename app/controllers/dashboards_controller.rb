class DashboardsController < ApplicationController
  before_filter :set_user_type
  
  def show
    case @user_type
    when :provider, :dealer, :admin
      render @user_type, layout: @user_type.to_s
    else
      render 'welcome'
    end
  end
end
