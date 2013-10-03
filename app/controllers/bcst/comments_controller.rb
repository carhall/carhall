class Bcst::CommentsController < Bcst::ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_provider
  before_filter :set_parent

  def index
    @comments = @parent
  end

private

  def set_parent
    @parent = @provider.programmes.find(params[:programme_id]).comments
  end
  
end
