class Api::Posts::PostsController < Api::Posts::ApplicationController
  before_filter :set_user, except: :show
  set_resource_class ::Posts::Post
  before_filter :set_includes

  # GET /api/posts
  # GET /api/posts.json
  def index
    render_index @parent.with_user @user
  end

  def friends
    render_index @parent.with_friends(@user)
  end

  def top
    render_index @parent.top
  end

  def club
    render_index @parent.with_club @user
  end

  # POST /api/posts
  # POST /api/posts.json
  def create
    render_create @user.posts.create data_params
  end

  # DELETE /api/posts/1
  # DELETE /api/posts/1.json
  def destroy
    post = @parent.find(params[:id])
    authorize! :destroy, post
    post.destroy

    render_accepted
  end

private
  
  def set_includes
    @parent = @parent.includes(:user, comments: [:user, :at_user])
  end

  def data_params
    params.require(:data).permit(:content, :image)
  end

end
