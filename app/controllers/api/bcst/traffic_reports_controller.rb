class Api::Bcst::TrafficReportsController < Api::Bcst::CommentsController

  def set_parent
    @provider = ::Accounts::Provider.find(params[:provider_id])
    @parent = @provider.traffic_reports.includes(:user, :at_user)
  end
  
  def data_params
    params.require(:data).permit(:content, :image, :at_user_id, :latitude, :longitude)
  end

end
