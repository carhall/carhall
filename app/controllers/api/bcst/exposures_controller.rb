class Api::Bcst::ExposuresController < Api::CommentsController

  def set_parent
    @provider = ::Accounts::Provider.find(params[:provider_id])
    @parent = @provider.exposures.includes(:user, :at_user)
  end
  
end
