class Api::PostBlacklistsController < Api::ApplicationController
  before_filter :set_user

  # GET /api/post_blacklists
  # GET /api/post_blacklists.json
  def index
    render_index @user.post_blacklists
  end

  # POST /api/post_blacklists/1
  # POST /api/post_blacklists/1.json
  def create
    block = @user.create_post_blacklist_with params[:id]
    if not block.new_record? or block.save
      render_create_success block, { data: block }
    else
      render_failure block
    end
  end

  # DELETE /api/post_blacklists/1
  # DELETE /api/post_blacklists/1.json
  def destroy
    @user.remove_post_blacklist params[:id]

    render_accepted
  end
  
end
