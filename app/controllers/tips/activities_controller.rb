class Tips::ActivitiesController < Tips::ApplicationController
  set_resource_class Activity, expiredable: true

end
