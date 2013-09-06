class Tips::CleaningsController < Tips::ApplicationController
  set_resource_class Cleaning, orders: true

end
