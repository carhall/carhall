class Api::MechanicsController < Api::BaseController
  before_filter :set_current_user
  before_filter :set_area_id_and_brand_id, except: :create

  # GET /api/mechanics
  # GET /api/mechanics.json
  def index
    detail = @user.detail
    mechanics = Mechanic.club(@area_id, @brand_id)
    render_index mechanics.all_users
  end

  # POST /api/mechanics
  # POST /api/mechanics.json
  def create
    render_create Mechanic.create params[:data].merge(user: @user)
  end

end
