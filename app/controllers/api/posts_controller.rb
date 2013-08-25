class Api::PostsController < Api::BaseController
  before_filter :set_user, except: :show

  # GET /api/posts
  # GET /api/posts.json
  def index
    render_show @user.posts
  end

  def friends
    render_show Post.user(@user.friend_ids)
  end

  # GET /api/posts
  # GET /api/posts.json
  def top
    render_show Post.order('comments_count DESC')
  end

  # GET /api/posts
  # GET /api/posts.json
  def club
    condition = {
      area_id: @user.detail.area_id,
      brand_id: @user.detail.brand_id,
    } if @user.user_type == :user
    
    render_show Post.where(condition)
  end

  # GET /api/posts/1
  # GET /api/posts/1.json
  def show
    render_show Post.view(params[:id])
  end

  # POST /api/posts
  # POST /api/posts.json
  def create
    render_create @user.posts.create params[:data]
  end

  # DELETE /api/posts/1
  # DELETE /api/posts/1.json
  def destroy
    @user.posts.find(params[:id]).destroy

    render_accepted
  end

  protected

  def set_user
    if user_id = params[:user_id]
      @user = BaseUser.find(user_id)
    else
      @user = current_base_user
    end
  end
end
