class Api::Posts::ClubsController < Api::Posts::ApplicationController
  before_filter :set_current_user

  # GET /api/club
  # GET /api/club.json
  def show
    render_show ::Posts::Club.with_user(@user)
  end

  # PUT /api/club
  # PUT /api/club.json
  def update
    club = ::Posts::Club.with_user(@user)
    authorize! :update, club
    if club.update_attributes(data_params)
      render_update_success club
    else
      render_failure club
    end
  end

  def president
    club = ::Posts::Club.with_user(@user)
    club.apply_president!(@user, params.require(:data).require(:description))
    # club.appoint_president @user
    if club.save
      render_created
    else
      render_failure club
    end
  end

  def mechanics
    club = ::Posts::Club.with_user(@user)
    club.apply_mechanic!(@user, params.require(:data).require(:description))
    # club.appoint_mechanic @user
    if club.save
      render_created
    else
      render_failure club
    end
  end

private

  def data_params
    params.require(:data).permit(:area_id, :brand_id, :announcement, :avatar)
  end

end
