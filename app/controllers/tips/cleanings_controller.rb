class Tips::CleaningsController < Tips::ApplicationController
  set_resource_class ::Tips::Cleaning, orders: true

end
