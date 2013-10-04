class Api::Bcst::CommentsController < Api::Bcst::ApplicationController
  set_resource_class ::Bcst::Comment

  def set_parent
    @programme = ::Bcst::Programme.find(params[:programme_id])
    @parent = @programme.comments
  end
  
end
