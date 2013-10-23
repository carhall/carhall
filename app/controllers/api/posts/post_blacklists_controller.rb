class Api::Posts::PostBlacklistsController < Api::Posts::ApplicationController
  before_filter :set_user

  # GET /api/post_blacklists
  # GET /api/post_blacklists.json
  def index
    render_index @user.post_blacklists
  end

  # POST /api/post_blacklists/1
  # POST /api/post_blacklists/1.json
  def create
    @user.add_to_post_blacklist! params[:id]
    render_created
  end

  # DELETE /api/post_blacklists/1
  # DELETE /api/post_blacklists/1.json
  def destroy
    @user.remove_from_post_blacklist! params[:id]
    render_accepted
  end
  
end
