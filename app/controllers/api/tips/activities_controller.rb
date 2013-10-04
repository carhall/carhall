class Api::Tips::ActivitiesController < Api::Tips::ApplicationController
  set_resource_class ::Tips::Activity

  def set_parent
    @parent = ::Tips::Activity.includes(:dealer)
    @parent = @parent.with_dealer params[:dealer_id] if params[:dealer_id]
    @parent = @parent.in_progress
  end
end
