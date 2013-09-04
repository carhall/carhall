class Api::CommentsController < Api::BaseController
  before_filter :set_parent

  # GET /api/resources/1/comments
  # GET /api/resources/1/comments.json
  def index
    render_index @parent.comments
  end

  # GET /api/resources/1/comments/1
  # GET /api/resources/1/comments/1.json
  def show
    render_show @parent.comments.find(params[:id])
  end

  # POST /api/resources/1/comments
  # POST /api/resources/1/comments.json
  def create
    render_create @parent.comments.create (params[:data]||{}).merge(user: current_base_user)
  end

  # DELETE /api/resources/1/comments/1
  # DELETE /api/resources/1/comments/1.json
  def destroy
    @parent.comments.user(current_base_user).find(params[:id]).destroy

    render_accepted
  end

  protected

  AccreditedKeys = {
    'post_id' => Post,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value)
        return
      end
    end
  end
  
end
