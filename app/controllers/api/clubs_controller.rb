class Api::ClubsController < Api::ApplicationController
  ensure_base_user_type :user
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
    if club.update_attributes(params[:data])
      render_update_success club
    else
      render_failure club
    end
  end

  def president
    club = Club.with_user(@user)
    # club.apply_president @user
    club.appoint_president @user
    if club.save
      render_created
    else
      render_failure club
    end
  end

  def mechanics
    club = Club.with_user(@user)
    # club.apply_mechanic @user
    club.appoint_mechanic @user
    if club.save
      render_created
    else
      render_failure club
    end
  end

end
