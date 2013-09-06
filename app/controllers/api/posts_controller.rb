class Api::PostsController < Api::ApplicationController
  before_filter :set_user, except: :show
  before_filter :set_area_id_and_brand_id, except: :create

  # GET /api/posts
  # GET /api/posts.json
  def index
    render_index @user.posts
  end

  def friends
    render_index Post.friends(@user)
  end

  # GET /api/posts
  # GET /api/posts.json
  def top
    render_index Post.top
  end

  # GET /api/posts
  # GET /api/posts.json
  def club
    if @user.user_type == :user
      detail = @user.detail
      render_index Post.club(detail.area_id, detail.brand_id)
    else
      render_index Post.all
    end
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

end
