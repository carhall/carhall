class Api::PostBlacklistsController < Api::ApplicationController
  ensure_base_user_type :user
  before_filter :set_user

  # GET /api/post_blacklists
  # GET /api/post_blacklists.json
  def index
    render_index @user.post_blacklists
  end

  # POST /api/post_blacklists/1
  # POST /api/post_blacklists/1.json
  def create
    block = @user.add_to_post_blacklist params[:id]
    if not block.new_record? or block.save
      render_create_success block, { data: block }
    else
      render_failure block
    end
  end

  # DELETE /api/post_blacklists/1
  # DELETE /api/post_blacklists/1.json
  def destroy
    @user.remove_from_post_blacklist params[:id]

    render_accepted
  end
  
end
