class Api::Tips::ActivitiesController < Api::Tips::ApplicationController
  set_resource_class Activity

  def parent
    Activity.includes(:dealer)
  end
end
