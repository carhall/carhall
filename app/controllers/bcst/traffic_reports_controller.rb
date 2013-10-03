class Bcst::TrafficReportsController < Bcst::CommentsController

private

  def set_parent
    @parent = @provider.traffic_reports
  end
  
end