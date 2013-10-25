class Api::Posts::PostsController < Api::Posts::ApplicationController
  before_filter :set_user, except: :show
  before_filter :set_api_template, only: [:index, :friends, :top, :club]
  before_filter :set_area_id_and_brand_id, except: :create

  # GET /api/posts
  # GET /api/posts.json
  def index
    render_index @user.posts
  end

  def friends
    render_index ::Posts::Post.with_friends(@user)
  end

  def top
    render_index ::Posts::Post.top
  end

  def club
    case @user.user_type
    when :user
      render_index @user.club.posts
    else
      render_index ::Posts::Post.all
    end
  end

  # GET /api/posts/1
  # GET /api/posts/1.json
  def show
    render_show ::Posts::Post.find(params[:id])
  end

  # POST /api/posts
  # POST /api/posts.json
  def create
    render_create @user.posts.create data_params
  end

  # DELETE /api/posts/1
  # DELETE /api/posts/1.json
  def destroy
    post = ::Posts::Post.find(params[:id])
    authorize! :destroy, post
    post.destroy

    render_accepted
  end

protected
  
  def set_api_template
    @api_template = if params[:detail]
      :detail
    else
      :base
    end
  end

  def render_index resources, api_template=@api_template
    super
  end

private
  
  def data_params
    params.require(:data).permit(:content, :image)
  end

end
