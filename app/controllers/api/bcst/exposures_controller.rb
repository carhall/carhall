class Api::Bcst::ExposuresController < Api::CommentsController

  def set_parent
    @provider = ::Accounts::Provider.find(params[:provider_id])
    @parent = @provider.exposures
  end
  
  def data_params
    params.require(:data).permit(:content, :image, :at_user_id)
  end

end
