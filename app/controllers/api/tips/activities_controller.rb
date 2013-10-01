class Api::Tips::ActivitiesController < Api::Tips::ApplicationController
  set_resource_class Tips::Activity

  def set_parent
    @parent = Tips::Activity.includes(:dealer)
    @parent = @parent.with_dealer @dealer if @dealer
  end
end
