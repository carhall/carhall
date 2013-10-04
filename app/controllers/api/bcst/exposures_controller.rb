class Api::Bcst::ExposuresController < Api::CommentsController
  set_resource_class ::Bcst::Exposure

  def set_parent
    @provider = ::Accounts::Provider.find(params[:provider_id])
    @parent = @provider.exposures
  end
  
end
