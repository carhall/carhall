class Api::Bcst::TrafficReportsController < Api::CommentsController
  set_resource_class ::Bcst::TrafficReport
  
  def set_parent
    @provider = ::Accounts::Provider.find(params[:provider_id])
    @parent = @provider.traffic_reports.includes(:user, :at_user)
  end
  
end
