class Api::CurrentUsersController < Api::ApplicationController
  before_filter :set_current_user

  # GET /api/current_user
  # GET /api/current_user.json
  def show
    render_show @user
  end

  # GET /api/current_user/detail
  # GET /api/current_user/detail.json
  def detail
    render_show @user.detail_hash request: request
  end

  # PUT /api/current_user
  # PUT /api/current_user.json
  # We need to use a copy of the @user because we don't want to change
  # the current user in place.
  def update
    if @user.update_without_password(params[:data])
      render_update_success @user
    else
      render_failure @user
    end
  end

  # PUT /api/current_user/password
  # PUT /api/current_user/password.json
  # We need to use a copy of the @user because we don't want to change
  # the current user in place.
  def password
    if @user.update_with_password(params[:data])
      render_update_success @user
    else
      render_failure @user
    end
  end

end
