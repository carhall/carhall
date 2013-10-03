class Api::CommentsController < Api::ApplicationController
  set_resource_class Share::Comment
  before_filter :set_current_user, only: :create

  # POST /api/resources/1/comments
  # POST /api/resources/1/comments.json
  def create
    render_create @parent.new data_params.merge(user: @current_user)
  end

  # DELETE /api/resources/1/comments/1
  # DELETE /api/resources/1/comments/1.json
  def destroy
    comment = @parent.find(params[:id])
    authorize! :destroy, comment
    comment.destroy

    render_accepted
  end

protected

  AccreditedKeys = {
    'post_id' => ::Posts::Post,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value).comments
        return
      end
    end
  end

private
  
  def data_params
    params.require(:data).permit(:content, :at_user_id)
  end

end
