class Api::ClubsController < Api::ApplicationController
  before_filter :set_current_user
  before_filter :set_area_id_and_brand_id, only: :show

  # GET /api/club
  # GET /api/club.json
  def show
    render_show Club.with_club(@area_id, @brand_id)
  end

  # PUT /api/club
  # PUT /api/club.json
  def update
    club = Club.with_user(@user)
    raise CanCan::AccessDenied unless club.president_id == @user.id
    if club.update_attributes(data_params)
      render_update_success club
    else
      render_failure club
    end
  end

  def president
    club = Club.with_user(@user)
    club.appoint_president @user
    # if club.apply_president(@user, params[:data][:description]).save
    if club.save
      render_created
    else
      render_failure club
    end
  end

  def mechanics
    club = Club.with_user(@user)
    club.appoint_mechanic @user
    # if club.apply_mechanic(@user, params[:data][:description]).save
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
