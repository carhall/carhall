class Api::BlacklistsController < Api::BaseController
  before_filter :set_user

  # GET /api/blacklists
  # GET /api/blacklists.json
  def index
    render_index @user.blacklists
  end

  # POST /api/blacklists/1
  # POST /api/blacklists/1.json
  def create
    block = @user.create_blacklist_with params[:id]
    if not block.new_record? or block.save
      render_create_success block, { data: block }
    else
      render_failure block
    end
  end

  # DELETE /api/blacklists/1
  # DELETE /api/blacklists/1.json
  def destroy
    @user.remove_blacklist params[:id]

    render_accepted
  end
  
end
