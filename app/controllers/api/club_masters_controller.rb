class Api::ClubMastersController < Api::ApplicationController
  before_filter :set_current_user
  before_filter :set_area_id_and_brand_id, except: :create

  # GET /api/club_master
  # GET /api/club_master.json
  def show
    club_master = ClubMaster.club(@area_id, @brand_id)
    render_show club_master.first_user
  end

  # GET /api/club_master/detail
  # GET /api/club_master/detail.json
  def detail
    club_master = ClubMaster.club(@area_id, @brand_id)
    render_show club_master.first_user.detail_hash
  end

  # POST /api/club_master
  # POST /api/club_master.json
  def create
    render_create ClubMaster.create params[:data].merge(user: @user)
  end

end
