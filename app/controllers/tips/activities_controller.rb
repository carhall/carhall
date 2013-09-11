class Tips::ActivitiesController < Tips::ApplicationController
  set_resource_class ::Tips::Activity, expiredable: true

end
