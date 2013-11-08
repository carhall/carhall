class DashboardsController < ApplicationController
  skip_before_filter :authenticate_account!

  def show
  end
end
